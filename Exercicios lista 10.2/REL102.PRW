#INCLUDE 'TOTVS.CH'
#INCLUDE 'REPORT.CH'
#INCLUDE 'TOPCONN.CH'

/*/{Protheus.doc} User Function REL102
    Função para imprimir todos os pedidos com seus produtos da lista 10.2
    @type  Function
    @author Lucas Leal
    @since 11/04/2023
    /*/
User Function REL102()
    local oReport := GeraRelatorio()

    oReport:PrintDialog()
Return 

Static Function GeraRelatorio()
    Local cAlias := GetNextAlias()
    local oReport := TReport():NEW('REL102', 'Relatório do Pedido de Venda',, {|oReport| ImprimeDados(oReport)}, 'Relatório para Impressão do Pedido de Compra', .F.)
    local oSection1   := TRSection():NEW(oReport, 'Pedido')
    local oSection2   := TRSection():NEW(oSection1, 'Itens')

    TRCELL():New(oSection1, 'C5_NUM'      , cAlias, 'Num Pedido',,         15)
    TRCELL():New(oSection1, 'A1_NOME'     , cAlias, 'Nome do Cliente',,   120)
    TRCELL():New(oSection1, 'C5_EMISSAO'  , cAlias, 'Data de Emissao'        )
    TRCELL():New(oSection1, 'E4_DESCRI'   , cAlias, 'Cond. Pagamento',,    40,,,'RIGHT' , .F., 'RIGHT' )

    TRCELL():New(oSection2, 'C6_ITEM'     , cAlias, 'Nº do Item',,         20)
    TRCELL():New(oSection2, 'C6_PRODUTO'  , cAlias, 'Codigo do Produto'      )
    TRCELL():New(oSection2, 'C6_DESCRI'   , cAlias, 'Descrição',,         140)
    TRCELL():New(oSection2, 'C6_QTDVEN'   , cAlias, 'Quantidade'             )
    TRCELL():New(oSection2, 'C6_PRCVEN'   , cAlias, 'Valor Unitario'         )
    TRCELL():New(oSection2, 'C6_VALOR'    , cAlias, 'Valor Total',,        40,,,'RIGHT' , .F., 'RIGHT' )

    oBreak := TRBreak():New(oSection1, oSection1:Cell('C5_NUM'), '', .T.)

    TRFunction():New(oSection2:Cell('C6_VALOR'), 'VALTOT', 'SUM', oBreak, 'Total',,, .F., .F., .F.)
    
Return oReport

Static Function ImprimeDados(oReport)
    Local cAlias    := GeraQuery()
    local oSection1  := oReport:Section(1)
    local oSection2  := oSection1:Section(1)
    local nTotReg := 0

    DbSelectArea(cAlias)

	Count TO nTotReg

    oReport:SetMeter(nTotReg)
    oReport:StartPage()
    oSection1:Init()
    
    (cAlias)->(DbGoTop())

    oSection1:Cell('C5_NUM'):SetValue((cAlias)->C5_NUM)
	oSection1:Cell('A1_NOME'):SetValue((cAlias)->A1_NOME)
	oSection1:Cell('C5_EMISSAO'):SetValue(STOD((cAlias)->C5_EMISSAO))
	oSection1:Cell('E4_DESCRI'):SetValue((cAlias)->E4_DESCRI)

    oSection1:PrintLine()

    oSection2:Init()
    
    (cAlias)->(DbGoTop())

	While (cAlias)->(!EOF())
		if oReport:Cancel()
			Exit
		endif

		oSection2:Cell('C6_ITEM'):SetValue((cAlias)->C6_ITEM)
		oSection2:Cell('C6_PRODUTO'):SetValue((cAlias)->C6_PRODUTO)
		oSection2:Cell('C6_DESCRI'):SetValue((cAlias)->C6_DESCRI)
		oSection2:Cell('C6_QTDVEN'):SetValue((cAlias)->C6_QTDVEN)
		oSection2:Cell('C6_PRCVEN'):SetValue((cAlias)->C6_PRCVEN)
		oSection2:Cell('C6_VALOR'):SetValue((cAlias)->C6_VALOR)

		oSection2:PrintLine()
		oReport:IncMeter()
		(cAlias)->(DbSkip())
	enddo

	(cAlias)->(DbCloseArea())
    oSection1:Finish()
    oSection2:Finish()
    oReport:EndPage()
Return

Static Function GeraQuery()
    Local cAlias := GetNextAlias()
	Local cQuery := ''

	cQuery :=  "SELECT C5.C5_NUM" + CRLF
    cQuery +=  "    ,A1.A1_NOME" + CRLF
    cQuery +=  "    ,C5.C5_EMISSAO" + CRLF
    cQuery +=  "    ,E4.E4_DESCRI" + CRLF
    cQuery +=  "    ,C6.C6_ITEM" + CRLF
    cQuery +=  "    ,C6.C6_PRODUTO" + CRLF
    cQuery +=  "    ,C6.C6_DESCRI" + CRLF
    cQuery +=  "    ,C6.C6_QTDVEN" + CRLF
    cQuery +=  "    ,C6.C6_PRCVEN" + CRLF
    cQuery +=  "    ,C6.C6_VALOR" + CRLF
    cQuery +=  "FROM " + RetSqlName('SC5') + " C5" + CRLF
    cQuery +=  "LEFT JOIN " + RetSqlName('SC6') + " C6" + CRLF
    cQuery +=  "    ON C5.C5_NUM = C6.C6_NUM" + CRLF
    cQuery +=  "LEFT JOIN " + RetSqlName('SA1') + " A1" + CRLF
    cQuery +=  "    ON C5.C5_CLIENTE = A1.A1_COD" + CRLF
    cQuery +=  "LEFT JOIN " + RetSqlName('SE4') + " E4" + CRLF
    cQuery +=  "    ON C5.C5_CONDPAG = E4.E4_CODIGO	" + CRLF
    cQuery +=  "    WHERE" + CRLF
    cQuery +=  "    C5.C5_NUM = '" + SC5->C5_NUM + "'" + CRLF
    cQuery +=  "    AND C5.D_E_L_E_T_ = ' '" + CRLF
    cQuery +=  "    AND C6.D_E_L_E_T_ = ' '" + CRLF
    cQuery +=  "    AND A1.D_E_L_E_T_ = ' '" + CRLF
    cQuery +=  "    AND E4.D_E_L_E_T_ = ' '" + CRLF
    cQuery +=  "    ORDER BY C5.C5_NUM" + CRLF

    TCQUERY cQuery NEW ALIAS &cAlias
return cAlias
