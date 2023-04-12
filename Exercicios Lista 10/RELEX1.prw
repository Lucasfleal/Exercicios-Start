#INCLUDE 'TOTVS.CH'
#INCLUDE 'REPORT.CH'
#INCLUDE 'TOPCONN.CH'
/*/{Protheus.doc} User Function RelEx1
    Relatorio em TReport para o cadastro de produto do exercicio 1 da lista 10
    @type  Function
    @author Lucas Leal
    @since 10/04/2023
    /*/
User Function RelEx1()
    local oReport := GeraRel()

    oReport:PrintDialog()
Return 

Static Function GeraRel()
    local oReport := TReport():New('RelEx1', 'Relatorio de Produtos',, {|oReport| Imprime(oReport)}, 'Impressão de todos os produtos cadastrados no sistema')
    local oSection  := TRSection():NEW(oReport, 'Seção dos Produtos', {'SB1'})

    TRCell():New(oSection, 'B1_COD'     , 'SB1', 'Código'   )
    TRCell():New(oSection, 'B1_DESC'    , 'SB1', 'Descrição')
    TRCell():New(oSection, 'B1_UM'      , 'SB1', 'Unidade de Medida')
    TRCell():New(oSection, 'B1_PRV1'    , 'SB1', 'Preço de Venda')
    TRCell():New(oSection, 'B1_LOCPAD'  , 'SB1', 'Armazem')


Return oReport

Static Function Imprime(oReport)
    local oSection  := oReport:Section(1)
    local cAlias    := GeraQuery()
    Local nTotReg	:= 0
    Local cPRV1     := ''
    
    DbSelectArea(cAlias)
    Count TO nTotReg
    
    oReport:SetMeter(nTotReg)
    oReport:StartPage()
    (cAlias)->(DBGOTOP())

    while !(cAlias)->(Eof())
        if oReport:Cancel()
            Exit            
        endif
        oSection:Init()
        cPRV1 := AllTrim((cAlias)->B1_PRV1)
        if cPRV1 == ''
            cPRV1 := '0.00'
        endif

        oSection:Cell('B1_COD'):SetValue(B1_COD)
        oSection:Cell('B1_DESC'):SetValue(B1_DESC)
        oSection:Cell('B1_UM'):SetValue(B1_UM)
        oSection:Cell('B1_PRV1'):SetValue('R$' + cPRV1)
        oSection:Cell('B1_LOCPAD'):SetValue(B1_LOCPAD)

        oSection:PrintLine()
        oReport:IncMeter()
        (cAlias)->(DBSkip())
    end
    oSection:Finish()
    (cAlias)->(DBCloseArea())
    oReport:EndPage()
Return 

Static Function GeraQuery()
	Local cAlias := GetNextAlias()
	Local cQuery := ''

	cQuery += 'SELECT' + CRLF
	cQuery += '	  B1_COD,' + CRLF
	cQuery += '   B1_DESC,' + CRLF
	cQuery += '   B1_UM,' + CRLF
	cQuery += '   B1_PRV1,' + CRLF
	cQuery += '   B1_LOCPAD' + CRLF
	cQuery += 'FROM' + CRLF
	cQuery += '	 ' + RetSqlName('SB1') + ' B1' + CRLF
	cQuery += 'WHERE' + CRLF
	cQuery += "D_E_L_E_T_ = ' '" + CRLF
	cQuery += 'ORDER BY B1_COD'

	TCQUERY cQuery NEW ALIAS &cAlias
Return cAlias
