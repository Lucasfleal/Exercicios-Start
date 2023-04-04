#INCLUDE 'Totvs.CH'

User Function L04Ex05()
    Local cTitle := 'Reajuste Salarial'
    Private cDias := "Qtd Dias: ", nDias := SPACE( 15 )
    Private cKm := "Km percorrido: ", nKm := SPACE( 15 )
    Private nRetorno := SPACE( 15 ), cResultado := "Valor a Pagar: "
    Private oBtnConf, oDlg, oRet

    Define MSDialog oDlg Title cTitle From 000,000 to 180,260 PIXEL

    @ 007, 026 SAY cDias Size 55, 07 Pixel OF oDlg PIXEL
    @ 014, 010 MSGET nDias Size 55, 11 Pixel OF oDlg PIXEL 

    @ 007, 076 SAY cKm Size 55, 07 Pixel OF oDlg PIXEL
    @ 014, 065 MSGET nKm Size 55, 11 Pixel OF oDlg PIXEL 

    @ 033, 060 SAY cResultado Size 55, 07 Pixel OF oDlg PIXEL
    @ 030, 095 MSGET oRet Var nRetorno Size 25, 11 Pixel OF oDlg PIXEL NO BORDER 
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000; background-color:#FEFEFE;}")

    @ 050, 010 BUTTON oBtnConf PROMPT "Calcular" Size 110, 20 PIXEL Of oDlg Action(CalValor())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    @ 070, 010 BUTTON oBtnConf PROMPT "Fechar" Size 110, 15 PIXEL Of oDlg Action(oDlg:End())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    ACTIVATE MSDialog ODlg CENTERED
Return 

Static Function CalValor()
    nRetorno := (val(nDias) * 60) + (val(nKm) * 0.15)
    oRet:Refresh()
Return 
