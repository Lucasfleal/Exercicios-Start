#INCLUDE 'FWMVCDEF.CH'
#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function MyMVC_2
    Exemplo de MVC 2
    @type  Function
    @author Lucas Leal
    @since 20/03/2023
    /*/
User Function MyMVC2()
    Local cAlias := 'ZZC'
    Local cTitle := 'Cursos'
    Local oBrowse := FwMBrowse():New()

    oBrowse:SetAlias(cAlias)
    oBrowse:SetDescription(cTitle)
    oBrowse:DisableDetails()
    oBrowse:DisableReport()
    oBrowse:ACTIVATE()
Return 

Static Function MenuDef()
    Local aRotina := {}

    ADD OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.MYMVC2' OPERATION 2 ACCESS 0
    ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.MYMVC2' OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.MYMVC2' OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE 'Excluir'    ACTION 'VIEWDEF.MYMVC2' OPERATION 5 ACCESS 0
Return aRotina

Static Function ModelDef()
    Local oModel := MPFormModel():New('MYMVC2M')
    Local oStruZZC := FwFormStruct(1, 'ZZC')
    Local oStruZZB := FwFormStruct(1, 'ZZB')

    oModel:AddFields('ZZCMASTER',, oStruZZC)
    oModel:SetDescription('Cursos')
    oModel:GetModel('ZZCMASTER'):SetDescription('Cursos')
    
    oModel:AddGrid('ZZBDETAIL', 'ZZCMASTER', oStruZZB)
    oModel:GetModel('ZZBDETAIL'):SetDescription('Alunos')
    oModel:SetRelation('ZZBDETAIL', {{'ZZB_FILIAL', 'xFilial("ZZB")'}, {'ZZB_CURSO', 'ZZC_COD'}}, ZZB->(IndexKey(1)))
    
    oModel:SetPrimaryKey({'ZZC_COD', 'ZZB_COD'})
Return oModel

Static Function VIEWDEF()
    Local oModel    :=  FwLoadModel('MYMVC2')
    Local oStruZZC  := FwFormStruct(2, 'ZZC')
    Local oStruZZB  := FwFormStruct(2, 'ZZB')
    Local oView     := FWFormView():New()

    oView:SetModel(oModel)
    oView:AddField('VIEW_ZZC', oStruZZC, 'ZZCMASTER')
    
    oView:AddGrid('VIEW_ZZB', oStruZZB, 'ZZBDETAIL')

    oView:CreateHorizontalBox('CURSO', 30)
    oView:CreateHorizontalBox('ALUNOS', 70)

    oView:SetOwnerView('VIEW_ZZC', 'CURSO')
    oView:SetOwnerView('VIEW_ZZB', 'ALUNOS')

    oView:EnableTitleView('VIEW_ZZC', 'Dados do Curso')
    oView:EnableTitleView('VIEW_ZZB', 'Alunos Matriculados')

    oView:SetViewAction('BUTTONOK', {|oView| MostraMsg(oView)})

    oView:SetFieldAction('ZZC_COD', {|oView| CarregaNome(oView)})

    oView:AddUserButton('Um Botão', 'CLIPS', {|| FwAlertInfo('Pronto!', 'Essa é a mensagem!')}, 'Botão de Mensagem',, {MODEL_OPERATION_INSERT, MODEL_OPERATION_UPDATE})

Return oView

Static Function MostraMsg(oView)
    Local nOper  := oView:GetOperation()
    Local cCurso := oView:GetValue('ZZCMASTER', 'ZZC_NOME')

    if nOper == 3
        FwAlertSuccess('Inclusão do curso <b>' + cCurso + '</b> realizada com sucesso!', 'SetViewAction')
    elseif nOper == 4
        FwAlertSuccess('Alteração do curso <b>' + cCurso + '</b> realizada com sucesso!', 'SetViewAction')
    elseif nOper == 5
        FwAlertSuccess('Exclusão do curso <b>' + cCurso + '</b> realizada com sucesso!', 'SetViewAction')
    endif
Return 

Static Function CarregaNome(oView)
    Local cNome  := 'Curso'
    Local oModel := oView:GetModel('ZZCMASTER')

    oModel:SetValue('ZZC_NOME', cNome)
    oView:Refresh()
Return 
