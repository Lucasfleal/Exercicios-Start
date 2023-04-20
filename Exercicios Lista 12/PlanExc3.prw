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

/*/{Protheus.doc} User Function PlanExc3
    Criação de Excel para a rotina de cursos
    @type  Function
    @author Lucas Leal
    @since 20/04/2023
    /*/
User Function PlanExc3()
    cAlias := GeraAlias()
    CriaExcel(cAlias)
Return 

Static Function GeraAlias()
    Local aArea  := GetArea()
    Local cAlias := GetNextAlias()
    
    cQuery := 'SELECT ZB.ZZB_COD, ZB.ZZB_NOME, ZA.ZZA_IDADE, ZC.ZZC_NOME' + CRLF +;
              'FROM ' + RetSqlName('ZZC') + ' ZC '+ CRLF +;
              'LEFT JOIN ' + RetSqlName('ZZB') + ' ZB ON ZB.ZZB_CURSO = ZC.ZZC_COD'+ CRLF +;
              'LEFT JOIN ' + RetSqlName('ZZA') + ' ZA ON ZB.ZZB_COD = ZA.ZZA_COD'+ CRLF +;
              "WHERE ZB.D_E_L_E_T_ = ' '" + CRLF +;
              "Order by ZC.ZZC_NOME"

    TCQUERY cQuery NEW ALIAS &cAlias

    RestArea(aArea)
Return cAlias

Static Function CriaExcel(cAlias)
    Local cPath  := 'C:\Users\Lucas Leal\Desktop\excel\' 
    local cArq   := 'Exercicio3.xls' 
    Local cCurso := ''
    Local cCursoAnt := ''
    Private oExcel := FwMsExcelEx():New()
    
    &(cAlias)->(DbGoTop())
    //? Adicionando dados
    while &(cAlias)->(!EOF())
        cCurso := ALLTRIM((cAlias)->(ZZC_NOME))
        if cCursoAnt <> cCurso
            //? Criando nova aba
            oExcel:AddworkSheet(cCurso)
            
            //? Adicionando nova tabela
            oExcel:AddTable(cCurso, 'Dados dos Alunos')
            
            //? colunas
            oExcel:AddColumn(cCurso, 'Dados dos Alunos', 'Codigo'    , LEFT  , GERAL)
            oExcel:AddColumn(cCurso, 'Dados dos Alunos', 'Nome'      , LEFT  , GERAL)
            oExcel:AddColumn(cCurso, 'Dados dos Alunos', 'Idade'     , CENTER, GERAL)

            cCursoAnt := cCurso
        endif
    
        oExcel:AddRow(cCurso, 'Dados dos Alunos', ;
                        {&(cAlias)->(ZZB_COD),    ;
                         &(cAlias)->(ZZB_NOME),   ;
                         &(cAlias)->(ZZA_IDADE)}     )

        &(cAlias)->(DbSkip())
    End

    //? Puxa o Estilo
    StyleExcel()

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

Static Function StyleExcel()
    oExcel:SetLineFont('Times New Roman')
    oExcel:SetLineSizeFont(10)
    oExcel:SetLineBgColor('#FFFFFF')
    oExcel:SetLineFrColor('#000000')

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
Return 

