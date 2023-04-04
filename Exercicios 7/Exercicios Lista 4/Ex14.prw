#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'TBICONN.CH'

User Function L04Ex14()
    Local aArea  := GetArea()
    Local cTitle := 'Pesquisa de pedidos por produto'
    Private cChamaCod := "Cód:", cCodigo := SPACE( 6 )
    Private oBtnConf, oDlg
    Private cDescricao, nValorVenda, cCod

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'FAT'

    Define MSDialog oDlg Title cTitle From 000,000 to 100,260 PIXEL

    @ 010, 010 SAY cChamaCod Size 55, 07 Pixel OF oDlg PIXEL
    @ 007, 030 MSGET oRet Var cCodigo Size 40, 11 Pixel OF oDlg PIXEL F3 "SB1" HASBUTTON

    @ 007, 075 BUTTON oBtnConf PROMPT "Buscar" Size 40, 13 PIXEL Of oDlg Action(BuscaCod())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    @ 030, 010 BUTTON oBtnConf PROMPT "Fechar" Size 110, 15 PIXEL Of oDlg Action(oDlg:End())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    ACTIVATE MSDialog ODlg CENTERED 
    RestArea(aArea)
RETURN

Static Function BuscaCod()
    Local aArea  := GetArea()
    Local cAlias := GetNextAlias()
    Local cQuery := ''
    Local cMsg   := ''
    Local cPedido := ''
    Local nCont  := 0
    
    
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC6' MODULO 'FAT'

    cQuery := 'SELECT C6_NUM' + CRLF
    cQuery += 'FROM ' + RetSqlName('SC6') + ' SC6 ' + CRLF
    cQuery += "WHERE C6_PRODUTO = '" + cCodigo + "' "

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    while &(cAlias)->(!EOF())
        cPedido  := &(cAlias)->(C6_NUM)
        cMsg += cPedido + CRLF
        nCont++

        &(cAlias)->(DbSkip())
    end

    &(cAlias)->(DbCloseArea())
    FwAlertInfo(cMsg, "Pedidos com o produto " + cCodigo)
  
    RestArea(aArea)
Return
