#INCLUDE 'FWMVCDEF.CH'
#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function MYMVC
    Exemplo de uso da classe FWBrowse
    @type  Function
    @author Lucas Leal
    @since 17/03/2023
    /*/
User Function MYMVC()
    Local cAlias := 'ZZC'
    Local cTitle := 'Cadastro de Cursos'
    Local oBrowse := FwMBrowse():New()

    oBrowse:SetAlias(cAlias)
    oBrowse:SetDescription(cTitle)
    oBrowse:DisableDetails()
    oBrowse:DisableReport()
    oBrowse:ACTIVATE()
Return 

Static Function MenuDef()
    Local aRotina := {}

    ADD OPTION aRotina TITLE 'Incluir' ACTION 'VIEWDEF.MYMVC' OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar' ACTION 'VIEWDEF.MYMVC' OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE 'Excluir' ACTION 'VIEWDEF.MYMVC' OPERATION 5 ACCESS 0
Return aRotina

Static Function ModelDef()
    Local oModel := MPFormModel():New('MYMVCM')
    Local oStruZZC := FwFormStruct(1, 'ZZC')

    oModel:AddFields('ZZCMASTER', ,oStruZZC)
    oModel:SetDescription('Modelo de dados de Cursos')
    oModel:GetModel('ZZCMASTER'):SetDescription('Formulario do Curso')
    oModel:SetPrimaryKey({'ZZC_COD'})
Return oModel

Static Function VIEWDEF()
    Local oModel    := FwLoadModel('MYMVC')
    Local oStruZZC  := FwFormStruct(2, 'ZZC')
    Local oView     := FwFormView():New()

    oView:SetModel(oModel)
    oView:AddField('VIEW_ZZC', oStruZZC, 'ZZCMASTER')
    oView:CreateHorizontalBox('TELA', 100)
    oView:SetOwnerView('VIEW_ZZC', 'TELA')
Return oView
