#INCLUDE 'FWMVCDEF.CH'
#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function MVCVS
    Visualização em MVC de categorias/instrutores/alunos
    @type  Function
    @author Lucas Leal
    @since 29/03/2023
    /*/
User Function MVCVISU()
    Local cAlias := 'SZC'
    Local cTitle := 'Visualização'
    Local oBrowse := FwMBrowse():New()

    //Configurando Browser
    oBrowse:SetAlias(cAlias)
    oBrowse:SetDescription(cTitle)
    oBrowse:DisableDetails()
    oBrowse:DisableReport()
    oBrowse:ACTIVATE()
Return 

Static Function MenuDef()
    Local aRotina := {}

    ADD OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.MVCVISU' OPERATION 2 ACCESS 0
Return aRotina

Static Function ModelDef()
    Local oModel := MPFormModel():New('MVCVISU')
    Local oStruSZC := FwFormStruct(1, 'SZC')
    Local oStruSZI := FwFormStruct(1, 'SZI')
    Local oStruSZA := FwFormStruct(1, 'SZA')

    //? Criando Modelos e seus relacionamentos
    oModel:AddFields('SZCMASTER',, oStruSZC)
    oModel:AddGrid('SZIDETAIL', 'SZCMASTER', oStruSZI)
    oModel:AddGrid('SZADETAIL', 'SZIDETAIL', oStruSZA)

    //? Setando as Descrições
    oModel:SetDescription('Categorias')
    oModel:GetModel('SZCMASTER'):SetDescription('Categorias')
    oModel:GetModel('SZADETAIL'):SetDescription('Alunos')
    oModel:GetModel('SZIDETAIL'):SetDescription('Instrutores')

    //? Setando relacionamento das tabelas   
    oModel:SetRelation('SZIDETAIL', {{'ZI_FILIAL', 'xFilial("SZI")'},;
                                     {'ZI_CATAULA', 'ZC_COD'}},;
                                     SZI->(IndexKey(1)))

    oModel:SetRelation('SZADETAIL', {{'ZA_FILIAL', 'xFilial("SZA")'},;
                                     {'ZA_INSTRUI', 'ZI_COD'}},;
                                     SZA->(IndexKey(1)))

    oModel:SetPrimaryKey({'ZC_COD', 'ZI_COD', 'ZA_COD'})
Return oModel

Static Function VIEWDEF()
    Local oModel    := FwLoadModel('MVCVS')
    Local oStruSZC  := FwFormStruct(2, 'SZC')
    Local oStruSZI  := FwFormStruct(2, 'SZI')
    Local oStruSZA  := FwFormStruct(2, 'SZA')
    Local oView     := FWFormView():New()

    oView:SetModel(oModel)

    oView:AddField('VIEW_SZC', oStruSZC, 'SZCMASTER')
    oView:AddGrid('VIEW_SZI', oStruSZI, 'SZIDETAIL')
    oView:AddGrid('VIEW_SZA', oStruSZA, 'SZADETAIL')

    oView:CreateHorizontalBox('CURSO', 30)
    oView:CreateHorizontalBox('INSTRUTOR', 30)
    oView:CreateHorizontalBox('ALUNOS', 40)

    oView:SetOwnerView('VIEW_SZC', 'CURSO')
    oView:SetOwnerView('VIEW_SZI', 'INSTRUTOR')
    oView:SetOwnerView('VIEW_SZA', 'ALUNOS')

    oView:EnableTitleView('VIEW_SZC', 'Categorias de Aula CNH')
    oView:EnableTitleView('VIEW_SZI', 'Instrutores')
    oView:EnableTitleView('VIEW_SZA', 'Alunos Matriculados')
Return oView
