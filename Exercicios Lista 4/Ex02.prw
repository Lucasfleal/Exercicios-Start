#INCLUDE 'Totvs.CH'

User Function L04Ex02()
    Local cTitle := 'Conversor de Dólar'
    Private cValorDolar := "Valor do Dólar: ", nValorDolar := SPACE( 15 )
    Private cQtdDolar := "Quantidade: ", nQtdDolar := SPACE( 15 )
    Private nRetorno := SPACE( 15 ), cResultado := "Resultado: "
    Private oRet, oBtnConf, oDlg

    Define MSDialog oDlg Title cTitle From 000,000 to 180,260 PIXEL

    @ 007, 21 SAY cValorDolar Size 55, 07 Pixel OF oDlg PIXEL
    @ 014, 010 MSGET nValorDolar Size 55, 11 Pixel OF oDlg PIXEL 

    @ 007, 076 SAY cQtdDolar Size 55, 07 Pixel OF oDlg PIXEL
    @ 014, 065 MSGET nQtdDolar Size 55, 11 Pixel OF oDlg PIXEL 

    @ 033, 065 SAY cResultado Size 55, 07 Pixel OF oDlg PIXEL
    @ 030, 095 MSGET oRet Var nRetorno Size 25, 11 Pixel OF oDlg PIXEL NO BORDER 
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000; background-color:#FEFEFE;}")

    @ 050, 010 BUTTON oBtnConf PROMPT "Converter" Size 110, 20 PIXEL Of oDlg Action(ConverteDolar())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")
    
    @ 070, 010 BUTTON oBtnConf PROMPT "Fechar" Size 110, 15 PIXEL Of oDlg Action(oDlg:End())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    ACTIVATE MSDialog ODlg CENTERED
Return 

Static Function ConverteDolar()
    nRetorno := val(nValorDolar) * val(nQtdDolar)
    oRet:Refresh()
Return 
