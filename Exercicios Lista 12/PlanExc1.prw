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

/*/{Protheus.doc} User Function PlanExc1
    Criação de Excel da lista 12 exercicio 1
    @type  Function
    @author Lucas Leal
    @since 19/04/2023
    /*/
User Function PlanExc1()
    cAlias := GeraAlias()
    CriaExcel(cAlias)
Return

Static Function CriaExcel(cAlias)
    Local oExcel := FwMsExcelEx():New()
    Local cPath  := 'C:\Users\Lucas Leal\Desktop\excel\' 
    local cArq   := 'Exercicio1.xls' 
    //? Criando nova aba
    oExcel:AddworkSheet('Fornecedores')
    
    //? Adicionando nova tabela
    oExcel:AddTable('Fornecedores', 'Dados da Empresa')
    
    //? colunas
    oExcel:AddColumn('Fornecedores', 'Dados da Empresa', 'Codigo'   , LEFT  , GERAL)
    oExcel:AddColumn('Fornecedores', 'Dados da Empresa', 'Nome'     , LEFT  , GERAL)
    oExcel:AddColumn('Fornecedores', 'Dados da Empresa', 'Loja'     , CENTER, NUMERO)
    oExcel:AddColumn('Fornecedores', 'Dados da Empresa', 'CNPJ'     , LEFT  , NUMERO)
    oExcel:AddColumn('Fornecedores', 'Dados da Empresa', 'Endereço' , CENTER, GERAL)
    oExcel:AddColumn('Fornecedores', 'Dados da Empresa', 'Bairro'   , CENTER, GERAL)
    oExcel:AddColumn('Fornecedores', 'Dados da Empresa', 'Cidade'   , CENTER, GERAL)
    oExcel:AddColumn('Fornecedores', 'Dados da Empresa', 'UF'       , CENTER, GERAL)
    //? estilos da linha 1
    oExcel:SetLineFont('Times New Roman')
    oExcel:SetLineSizeFont(10)
    oExcel:SetLineBgColor('#FFFFFF')
    oExcel:SetLineFrColor('#000000')
    
    //? estilos da linha 2
    oExcel:Set2LineFont('Times New Roman')
    oExcel:Set2LineSizeFont(10)
    oExcel:Set2LineBgColor('#A9A9A9')
    oExcel:Set2LineFrColor('#FFFFFF')
    
    &(cAlias)->(DbGoTop())
        //? Adicionando dados
    while &(cAlias)->(!EOF())
        oExcel:AddRow('Fornecedores', 'Dados da Empresa', ;
                        {&(cAlias)->(A2_COD),   ;
                        &(cAlias)->(A2_NOME),   ;
                        &(cAlias)->(A2_LOJA),   ;
                        &(cAlias)->(A2_CGC),    ;
                        &(cAlias)->(A2_END),    ;
                        &(cAlias)->(A2_BAIRRO), ;
                        &(cAlias)->(A2_MUN),    ;
                        &(cAlias)->(A2_EST)}    )

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

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SA2' MODULO 'COM'
    
    cQuery := 'SELECT * FROM ' + RetSqlName('SA2') + ' SA2 ' + CRLF +;
              "WHERE D_E_L_E_T_ = ' ' "

    TCQUERY cQuery NEW ALIAS &cAlias

    RestArea(aArea)
Return cAlias
