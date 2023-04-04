#INCLUDE 'TOTVS.CH'

User Function L04Ex01()
    Local cTitle := 'Calculadora'
    Private cValor1 := "Valor 1", nValor1 := SPACE( 5 )
    Private cValor2 := "Valor 2", nValor2 := SPACE( 5 )
    Private nRetorno := SPACE( 10 ), cResultado := "Resultado: "
    Private oRet, oBtnConf, oDlg

    Define MSDialog oDlg Title cTitle From 000,000 to 220,260 PIXEL

    @ 007, 029 SAY cValor1 Size 55, 07 Pixel OF oDlg PIXEL
    @ 014, 010 MSGET nValor1 Size 55, 11 Pixel OF oDlg PIXEL

    @ 007, 084 SAY cValor2 Size 55, 07 Pixel OF oDlg PIXEL
    @ 014, 065 MSGET nValor2 Size 55, 11 Pixel OF oDlg PIXEL

    @ 033, 065 SAY cResultado Size 55, 07 Pixel OF oDlg PIXEL
    @ 030, 095 MSGET oRet Var nRetorno Size 25, 11 Pixel OF oDlg PIXEL NO BORDER
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000; background-color:#FEFEFE;}")

    @ 050, 010 BUTTON oBtnConf PROMPT "Soma" Size 55, 15 PIXEL Of oDlg Action(Operacao("S"))
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")
    @ 050, 065 BUTTON oBtnConf PROMPT "Diferença" Size 55, 15 PIXEL Of oDlg Action(Operacao("D"))
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")
    @ 070, 010 BUTTON oBtnConf PROMPT "Produto" Size 55, 15 PIXEL Of oDlg Action(Operacao("P"))
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")
    @ 070, 065 BUTTON oBtnConf PROMPT "Quociente" Size 55, 15 PIXEL Of oDlg Action(Operacao("Q"))
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    @ 090, 010 BUTTON oBtnConf PROMPT "Fechar" Size 110, 15 PIXEL Of oDlg Action(oDlg:End())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    ACTIVATE MSDialog ODlg CENTERED
Return 

Static Function Operacao(cTipo)
    Do Case
    Case cTipo == 'S'
        nRetorno := val(nValor1) + val(nValor2)
        oRet:Refresh()
    Case cTipo == 'D'
        nRetorno := val(nValor1) - val(nValor2)
        oRet:Refresh()
    Case cTipo == 'P'
        nRetorno := val(nValor1) * val(nValor2)
        oRet:Refresh()
    Case cTipo == 'Q'
        nRetorno := val(nValor1) / val(nValor2)
        oRet:Refresh()
    EndCase 
Return 
