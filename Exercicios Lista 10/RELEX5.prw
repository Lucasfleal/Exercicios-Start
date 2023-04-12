#INCLUDE 'TOTVS.CH'
#INCLUDE 'REPORT.CH'

/*/{Protheus.doc} User Function L10EX05
    Função para imprimir todos os pedidos com seus produtos, exercicio 5 da lista 10
    @type  Function
    @author Lucas Leal
    @since 10/04/2023
    /*/
User Function RELEX5()
    local oReport := GeraRelatorio()

    oReport:PrintDialog()
Return 

Static Function GeraRelatorio()
    local cAlias     := GetNextAlias()
    local oReport := TReport():NEW('RELEX5', 'Relatório do Pedido de Compra',, {|oReport| ImprimeDados(oReport,cAlias)}, 'Relatório para Impressão do Pedido de Compra', .F.)
    local oSection1   := TRSection():NEW(oReport, 'Pedido')
    local oSection2   := TRSection():NEW(oSection1, 'Itens')

    TRCELL():New(oSection1, 'C7_NUM'     , 'SC7', 'Num Pedido'       )
    TRCELL():New(oSection1, 'C7_EMISSAO' , 'SC7', 'Data de Emissao',, 150 )
    TRCELL():New(oSection1, 'C7_FORNECE' , 'SC7', 'Código Fornecedor')
    TRCELL():New(oSection1, 'C7_LOJA'    , 'SC7', 'Loja'             )
    TRCELL():New(oSection1, 'C7_COND'    , 'SC7', 'Cond. Pagamento'  )

    TRCELL():New(oSection2, 'C7_PRODUTO' , 'SC7', 'Produto'          )
    TRCELL():New(oSection2, 'C7_DESCRI'  , 'SC7', 'Descrição',,   120)
    TRCELL():New(oSection2, 'C7_QUANT'   , 'SC7', 'Quantidade'       )
    TRCELL():New(oSection2, 'C7_PRECO'   , 'SC7', 'Preço'            )
    TRCELL():New(oSection2, 'C7_TOTAL'   , 'SC7', 'Total'            )

    oBreak := TRBreak():New(oSection1, oSection1:Cell('C7_NUM'), '', .T.)
    TRFunction():New(oSection2:Cell('C7_TOTAL'), 'VALTOT', 'SUM', oBreak, 'Total',,, .F., .F., .F.)
    
Return oReport

Static Function ImprimeDados(oReport,cAlias)
    local oSection1  := oReport:Section(1)
    local oSection2  := oSection1:Section(1)
    local cPedido    := ''
    local nTotalReg  := 0
    local cQuery     := GeraQuery()
    local lPage      := .f.

    DbUseArea(.T., 'TOPCONN', TcGenQry(,,cQuery), cAlias, .T., .T.)

    COUNT TO nTotalReg

    oReport:SetMeter(nTotalReg)
 
    (cAlias)->(DbGoTop())
 
    while (cAlias)->(!EOF())
        if oReport:Cancel()
            exit
        endif

        if cPedido <> Alltrim((cAlias)->(C7_NUM)) //! Verifica se é o mesmo pedido
            if !lPage
                oReport:StartPage()
                lPage := .T.
            else
                oSection2:Finish()
                oSection1:Finish()
                oReport:EndPage()
                oReport:StartPage()
            endif
            oSection1:Init()

            oSection1:Cell('C7_NUM'):SetValue((cAlias)->(C7_NUM))
            oSection1:Cell('C7_EMISSAO'):SetValue(STOD((cAlias)->(C7_EMISSAO)))
            oSection1:Cell('C7_FORNECE'):SetValue((cAlias)->(C7_FORNECE))
            oSection1:Cell('C7_LOJA'):SetValue((cAlias)->(C7_LOJA))
            oSection1:Cell('C7_COND'):SetValue((cAlias)->(C7_COND))

            cPedido := Alltrim((cAlias)->(C7_NUM))
            oSection1:PrintLine()
            oSection2:Init()
        endif

        //! Imprime os Itens do Pedido
        oSection2:Cell('C7_PRODUTO'):SetValue((cAlias)->(C7_PRODUTO))
        oSection2:Cell('C7_DESCRI'):SetValue((cAlias)->(C7_DESCRI))
        oSection2:Cell('C7_QUANT'):SetValue((cAlias)->(C7_QUANT))
        oSection2:Cell('C7_PRECO'):SetValue((cAlias)->(C7_PRECO))
        oSection2:Cell('C7_TOTAL'):SetValue((cAlias)->(C7_TOTAL))

        oSection2:PrintLine()
        oReport:IncMeter()

        (cAlias)->(DbSkip())
    enddo
    
    (cAlias)->(DbCloseArea())

    oSection2:Finish()
    oSection1:Finish()
    oReport:EndPage()
Return

Static Function GeraQuery()
    local cQuery := ''

    cQuery := 'SELECT C7_NUM, C7_EMISSAO, C7_FORNECE, C7_LOJA, C7_COND, C7_PRODUTO, C7_DESCRI, C7_QUANT, C7_PRECO, C7_TOTAL FROM ' + RetSqlName('SC7') + CRLF
    cQuery += "WHERE D_E_L_E_T_ = ' '" + CRLF
    cQuery += "ORDER BY C7_NUM"
Return cQuery
                