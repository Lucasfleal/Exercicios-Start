#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function BusProdGen()
    Local aArea := GetArea()
    Local cAlias := GetNextAlias()
    Local cQuery := ''
    Local cCodigo := 'C00001'
    Local cDescri := ''

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    cQuery := 'SELECT B1_DESC' + CRLF
    cQuery += 'FROM ' + RetSqlName('SB1') + ' SB1' + CRLF
    cQuery +=  "WHERE B1_COD = '" + cCodigo + "'"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    while &(cAlias)->(!EOF())
        cDescri := &(cAlias)->(B1_DESC)
        &(cAlias)->(DBSKIP())
    end

    FwAlertInfo("Código: " + cCodigo + CRLF + 'Descrição: ' + cDescri, 'Produto')

    &(cAlias)->(DBCLOSEAREA())
    RestArea(aArea)
Return 
