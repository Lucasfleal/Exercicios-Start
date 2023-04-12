#INCLUDE 'TOTVS.CH'
#INCLUDE 'REPORT.CH'

/*/{Protheus.doc} User Function RELEX4
    Função para imprimir todos os pedidos com seus produtos, exercicio 4 da lista 10
    @type  Function
    @author Lucas Leal
    @since 10/04/2023
    /*/
User Function RELEX4()
    local oReport := GeraRelatorio()

    oReport:PrintDialog()
Return 

Static Function GeraRelatorio()
    local oReport := TReport():NEW('RELEX4', 'Relatório do Pedido de Compra',, {|oReport| ImprimeDados(oReport)}, 'Relatório para Impressão do Pedido de Compra', .F.)
    local oSection1   := TRSection():NEW(oReport, 'Pedido')
    local oSection2   := TRSection():NEW(oSection1, 'Itens')

    TRCELL():New(oSection1, 'C7_NUM'     , 'SC7', 'Num Pedido'       )
    TRCELL():New(oSection1, 'C7_EMISSAO' , 'SC7', 'Data de Emissao'  )
    TRCELL():New(oSection1, 'C7_FORNECE' , 'SC7', 'Código Fornecedor')
    TRCELL():New(oSection1, 'C7_LOJA'    , 'SC7', 'Loja'             )
    TRCELL():New(oSection1, 'C7_COND'    , 'SC7', 'Cond. Pagamento'  )

    TRCELL():New(oSection2, 'C7_PRODUTO' , 'SC7', 'Produto'          )
    TRCELL():New(oSection2, 'C7_DESCRI'  , 'SC7', 'Descrição'        )
    TRCELL():New(oSection2, 'C7_QUANT'   , 'SC7', 'Quantidade'       )
    TRCELL():New(oSection2, 'C7_PRECO'   , 'SC7', 'Preço'            )
    TRCell():New(oSection2, 'C7_TOTAL'   , 'SC7', 'VLR TOTAL'   ,/*PICTURE*/     , 8  ,,,'CENTER' , .F., 'CENTER' ,,, .T.,,, .T.)

    oBreak := TRBreak():New(oSection1, oSection1:Cell('C7_NUM'), '', .T.)

    TRFunction():New(oSection2:Cell('C7_TOTAL'), 'VALTOT', 'SUM', oBreak, 'Total',,, .F., .F., .F.)
    
Return oReport

Static Function ImprimeDados(oReport)
    Local cAlias := GetNextAlias()
    Local cQuery    := GeraQuery()
    local oSection1  := oReport:Section(1)
    local oSection2  := oSection1:Section(1)

    DbUseArea(.T., 'TOPCONN', TcGenQry(/*Compat*/,/*Compat*/, cQuery), cAlias, .T., .T.)
	Count TO nTotReg

    oReport:SetMeter(nTotReg)
    oReport:StartPage()
    oSection1:Init()
    
    (cAlias)->(DbGoTop())

    oSection1:Cell('C7_NUM'):SetValue((cAlias)->C7_NUM)
	oSection1:Cell('C7_EMISSAO'):SetValue((cAlias)->C7_EMISSAO)
	oSection1:Cell('C7_FORNECE'):SetValue((cAlias)->C7_FORNECE)
	oSection1:Cell('C7_LOJA'):SetValue((cAlias)->C7_LOJA)
	oSection1:Cell('C7_COND'):SetValue((cAlias)->C7_COND)

    oSection1:PrintLine()
    
    oSection2:Init()
    
    (cAlias)->(DbGoTop())

	While (cAlias)->(!EOF())
		if oReport:Cancel()
			Exit
		endif

		oSection2:Cell('C7_PRODUTO'):SetValue((cAlias)->C7_PRODUTO)
		oSection2:Cell('C7_DESCRI'):SetValue((cAlias)->C7_DESCRI)
		oSection2:Cell('C7_QUANT'):SetValue((cAlias)->C7_QUANT)
		oSection2:Cell('C7_PRECO'):SetValue((cAlias)->C7_PRECO)
		oSection2:Cell('C7_TOTAL'):SetValue((cAlias)->C7_TOTAL)

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
	Local cQuery := ''

	cQuery := 'SELECT * FROM ' + RetSqlName('SC7') + ' SC7' + CRLF
	cQuery += "WHERE D_E_L_E_T_ = ' ' AND C7_NUM = '" + SC7->C7_NUM + "' "
return cQuery
