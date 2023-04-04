#INCLUDE 'Totvs.CH'

User Function L04Ex03()
    Local cTitle := 'Reajuste Salarial'
    Private cSalario := "Salário:", nSalario := SPACE( 15 )
    Private cReajuste := "Reajuste (%): ", nReajuste := SPACE( 15 )
    Private nRetorno := SPACE( 15 ), cResultado := "Resultado: "
    Private oRet, oBtnConf, oDlg

    Define MSDialog oDlg Title cTitle From 000,000 to 180,260 PIXEL

    @ 007, 026 SAY cSalario Size 55, 07 Pixel OF oDlg PIXEL
    @ 014, 010 MSGET nSalario Size 55, 11 Pixel OF oDlg PIXEL 

    @ 007, 076 SAY cReajuste Size 55, 07 Pixel OF oDlg PIXEL
    @ 014, 065 MSGET nReajuste Size 55, 11 Pixel OF oDlg PIXEL 

    @ 033, 010 SAY cResultado Size 55, 07 Pixel OF oDlg PIXEL
    @ 030, 065 MSGET oRet Var nRetorno Size 55, 11 Pixel OF oDlg PIXEL NO BORDER PICTURE "@E 999,999.99" HasButton
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000; background-color:#FEFEFE;}")

    @ 050, 010 BUTTON oBtnConf PROMPT "Calcular" Size 110, 20 PIXEL Of oDlg Action(ReajusteCalc())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    @ 070, 010 BUTTON oBtnConf PROMPT "Fechar" Size 110, 15 PIXEL Of oDlg Action(oDlg:End())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    ACTIVATE MSDialog ODlg CENTERED
Return 

Static Function ReajusteCalc()
    Local nTempVal := val(nSalario)
    nRetorno := nTempVal + ( nTempVal * (val(nReajuste)/100))
    oRet:Refresh()
Return 
