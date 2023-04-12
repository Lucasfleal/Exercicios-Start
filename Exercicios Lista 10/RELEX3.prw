#INCLUDE 'TOTVS.CH'
#INCLUDE 'REPORT.CH'

/*/{Protheus.doc} User Function RELEX3
    Função para imprimir todos os pedidos com seus produtos, exercicio 3 da lista 10
    @type  Function
    @author Lucas Leal
    @since 10/04/2023
    /*/
User Function RELEX3()
    local oReport := GeraRelatorio()

    oReport:PrintDialog()
Return 

Static Function GeraRelatorio()
    local oReport := TReport():NEW('RELEX3', 'Relatório do Pedido de Compra',, {|oReport| ImprimeDados(oReport)}, 'Relatório para Impressão do Pedido de Compra', .F.)
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
    TRCELL():New(oSection2, 'C7_TOTAL'   , 'SC7', 'Total'            )

    TRFunction():New(oSection2:Cell('C7_TOTAL'), 'VALTOT', 'SUM', oBreak, 'VALOR TOTAL',,, .F., .F., .F.)
    
Return oReport

Static Function ImprimeDados(oReport)
    local oSection1  := oReport:Section(1)
    local oSection2  := oReport:Section(2)

    DbSelectArea('SC7')

    oReport:StartPage()
    oSection1:Init()

    oSection1:Cell('C7_NUM'):SetValue(M->C7_NUM)
    oSection1:Cell('C7_EMISSAO'):SetValue(M->C7_EMISSAO)
    oSection1:Cell('C7_FORNECE'):SetValue(M->C7_FORNECE)
    oSection1:Cell('C7_LOJA'):SetValue(M->C7_LOJA)
    oSection1:Cell('C7_COND'):SetValue(M->C7_COND)

    oSection1:PrintLine()
    oSection1:Finish()

    oSection2:Init()

    oSection2:Cell('C7_PRODUTO'):SetValue(M->C7_PRODUTO)
    oSection2:Cell('C7_DESCRI'):SetValue(M->C7_DESCRI)
    oSection2:Cell('C7_QUANT'):SetValue(M->C7_QUANT)
    oSection2:Cell('C7_PRECO'):SetValue(M->C7_PRECO)
    oSection2:Cell('C7_TOTAL'):SetValue(M->C7_TOTAL)

    oSection2:PrintLine()
    oReport:IncMeter()

    oReport:EndPage()
    SC7->(DbCloseArea())
Return

