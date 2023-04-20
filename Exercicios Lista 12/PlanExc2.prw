#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'TBICONN.CH'

#DEFINE LEFT      1
#DEFINE CENTER    2
#DEFINE RIGHT     3
#DEFINE GERAL     1
#DEFINE NUMERO    2
#DEFINE MONETARIO 3
#DEFINE DATETIME  4

/*/{Protheus.doc} User Function PlanExc2
    Criação de Excel da lista 12 exercicio 2
    @type  Function
    @author Lucas Leal
    @since 19/04/2023
    /*/
User Function PlanExc2()
    cAlias := GeraAlias()
    CriaExcel(cAlias)
Return

Static Function CriaExcel(cAlias)
    Local oExcel := FwMsExcelEx():New()
    Local cPath  := 'C:\Users\Lucas Leal\Desktop\excel\' 
    local cArq   := 'Exercicio2.xls' 
    //? Criando nova aba
    oExcel:AddworkSheet('Produtos')
    
    //? Adicionando nova tabela
    oExcel:AddTable('Produtos', 'Dados dos Produtos')
    
    //? colunas
    oExcel:AddColumn('Produtos', 'Dados dos Produtos', 'Codigo'         , LEFT  , GERAL)
    oExcel:AddColumn('Produtos', 'Dados dos Produtos', 'Descrição'      , LEFT  , GERAL)
    oExcel:AddColumn('Produtos', 'Dados dos Produtos', 'Tipo'           , CENTER, GERAL)
    oExcel:AddColumn('Produtos', 'Dados dos Produtos', 'Uni. de Medida' , CENTER, GERAL)
    oExcel:AddColumn('Produtos', 'Dados dos Produtos', 'Preço de Venda' , CENTER, MONETARIO)

    oExcel:SetLineFont('Times New Roman')
    oExcel:SetLineSizeFont(10)
    oExcel:SetLineBgColor('#FFFFFF')
    oExcel:SetLineFrColor('#000000')

    oExcel:SetCelFrColor("#FF0000")
    oExcel:SetCelFont('Times New Roman')
    oExcel:SetCelSizeFont(10)
    oExcel:SetCelBgColor('#FFFFFF')
    
    &(cAlias)->(DbGoTop())
    //? Adicionando dados
    while &(cAlias)->(!EOF())
        if ((cAlias)->Del) == ' '
            oExcel:AddRow('Produtos', 'Dados dos Produtos', ;
                        {&(cAlias)->(B1_COD),   ;
                         &(cAlias)->(B1_DESC),  ;
                         &(cAlias)->(B1_TIPO),  ;
                         &(cAlias)->(B1_UM),    ;
                         &(cAlias)->(B1_PRV1)}  )
        
        else
            oExcel:AddRow('Produtos', 'Dados dos Produtos', ;
                        {&(cAlias)->(B1_COD),   ;
                         &(cAlias)->(B1_DESC),  ;
                         &(cAlias)->(B1_TIPO),  ;
                         &(cAlias)->(B1_UM),    ;
                         &(cAlias)->(B1_PRV1)},{1,2,3,4,5}  )
        endif

        &(cAlias)->(DbSkip())
    End

    //? Estilos título
    oExcel:SetTitleFont('Arial Black')
    oExcel:SetTitleSizeFont(12)
    oExcel:SetTitleBold(.T.)
    oExcel:SetTitleBgColor('#000000')
    oExcel:SetTitleFrColor('#FFFFFF')

    //? Estilos cabeçalho
    oExcel:SetHeaderFont('Arial')
    oExcel:SetHeaderSizeFont(12)
    oExcel:SetHeaderBold(.T.)
    oExcel:SetBgColorHeader('#4F4F4F')
    oExcel:SetFrColorHeader('#FFFFFF')

    oExcel:Activate()

    oExcel:GetXMLFile(cPath + cArq)

    if ApOleClient('MsExcel')
        oExec := MsExcel():New()
        oExec:WorkBooks:Open(cPath + cArq)
        oExec:SetVisible(.T.)
        oExec:Destroy()
    else
        cMsg := 'Microsoft Excel não encontrado!' + CRLF
        cMsg += 'Arquivo salvo em: ' + cPath + cArq
        FwAlertError(cMsg, 'Atenção!')
    endif
    &(cAlias)->(DbCloseArea())
    oExcel:DeActivate()
Return 

Static Function GeraAlias()
    Local aArea  := GetArea()
    Local cAlias := GetNextAlias()

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'
    
    cQuery := 'SELECT *, D_E_L_E_T_ AS DEL FROM ' + RetSqlName('SB1') + ' SB1 ' 

    TCQUERY cQuery NEW ALIAS &cAlias

    RestArea(aArea)
Return cAlias
