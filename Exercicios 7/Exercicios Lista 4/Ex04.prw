#INCLUDE 'Totvs.CH'

User Function L04Ex04()
    Local cTitle := 'Calculo de Tinta'
    Private cLargura := "Largura:", nLargura := SPACE( 15 )
    Private cAltura := "Altura: ", nAltura := SPACE( 15 )
    Private oBtnConf, oDlg

    Define MSDialog oDlg Title cTitle From 000,000 to 180,260 PIXEL

    @ 007, 026 SAY cAltura Size 55, 07 Pixel OF oDlg PIXEL
    @ 014, 010 MSGET nAltura Size 55, 11 Pixel OF oDlg PIXEL 

    @ 007, 080 SAY cLargura Size 55, 07 Pixel OF oDlg PIXEL
    @ 014, 065 MSGET nLargura Size 55, 11 Pixel OF oDlg PIXEL 

    @ 050, 010 BUTTON oBtnConf PROMPT "Calcular" Size 110, 20 PIXEL Of oDlg Action(ContaTinta())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    @ 070, 010 BUTTON oBtnConf PROMPT "Fechar" Size 110, 15 PIXEL Of oDlg Action(oDlg:End())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    ACTIVATE MSDialog ODlg CENTERED
Return 

Static Function ContaTinta()
    Local nTempVal := val(nLargura) * val(nAltura)
    
    FwAlertInfo('Será nessário ' + CVALTOCHAR(Ceiling(nTempVal/2)) + " latas de tinta para pintar " + CVALTOCHAR( nTempVal ) + " metros quadrados de parede", "Resultado" )

Return 
