#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'TBICONN.CH'

User Function L04Ex12()
    Local cTitle := 'Folha de Pagamento'
    Local cDataIni := "Data Inicial", dDataIni := Date()
    Local cDataFim := "Data Final", dDataFim := Date()
    Private oBtnConf, oDlg
    Private dTeste := Date()

    Set(_SET_EPOCH, 1980)

    Define MSDialog oDlg Title cTitle From 000,000 to 140,260 PIXEL

    @ 007, 026 SAY cDataIni Size 55, 07 Pixel OF oDlg PIXEL
    @ 014, 010 MSGET oRet Var dDataIni Size 55, 11 Pixel OF oDlg PIXEL PICTURE "@D" HASBUTTON

    @ 007, 068 SAY cDataFim Size 55, 07 Pixel OF oDlg PIXEL
    @ 014, 065 MSGET oRet Var dDataFim Size 55, 11 Pixel OF oDlg PIXEL PICTURE "@D" HASBUTTON

    @ 030, 010 BUTTON oBtnConf PROMPT "Buscar" Size 110, 20 PIXEL Of oDlg Action(BuscaPedido(dDataIni, dDataFim))
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    @ 050, 010 BUTTON oBtnConf PROMPT "Fechar" Size 110, 15 PIXEL Of oDlg Action(oDlg:End())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    ACTIVATE MSDialog ODlg CENTERED 
RETURN

Static Function BuscaPedido(dDataIni, dDataFim)
    Local aArea  := GetArea()
    Local cAlias := GetNextAlias()
    Local cQuery := ''
    Local cCod   := ''
    Local cMsg   := ''
    Local nCont  := 0
    Local cDataIni, cDataFim
    cDataIni := DTOS(dDataIni)
    cDataFim := DTOS(dDataFim)
    
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC5' MODULO 'FAT'

    cQuery := 'SELECT C5_NUM ' + CRLF
    cQuery += 'FROM ' + RetSqlName('SC5') + ' SC5 ' + CRLF
    cQuery += "WHERE D_E_L_E_T_ = ' ' " + CRLF
    cQuery += "AND  C5_EMISSAO BETWEEN '" + cDataIni + "' AND '" + cDataFim + "'"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    while &(cAlias)->(!EOF())
        cCod  := &(cAlias)->(C5_NUM)
        cMsg += 'Pedido : ' + cCod + CRLF
        nCont++

        if nCont == 10
            FwAlertInfo(cMsg, 'Pedidos no Intervalo')
            nCont := 0
            cMsg  := ''    
        endif

        &(cAlias)->(DbSkip())
    end

    if nCont > 0
        FwAlertInfo(cMsg, 'Pedidos no Intervalo')
    endif
    &(cAlias)->(DbCloseArea())
  
    RestArea(aArea)
Return 
