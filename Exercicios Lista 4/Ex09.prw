#INCLUDE 'Totvs.CH'

User Function L04Ex09()
    Local cTitle := 'Calculo de TMB'
    Private cPeso := "Peso:", nPeso := SPACE( 5 )
    Private cAltura := "Altura (cm): ", nAltura := SPACE( 3 )
    Private cIdade := "Idade: ", nIdade := SPACE( 2 )
    Private oBtnConf, oDlg
    Private nOpcao

    Define MSDialog oDlg Title cTitle From 000,000 to 180,260 PIXEL

    @ 007, 026 SAY cAltura Size 55, 07 Pixel OF oDlg PIXEL 
    @ 014, 010 MSGET nAltura Size 55, 11 Pixel OF oDlg PIXEL picture "999"

    @ 007, 085 SAY cPeso Size 55, 07 Pixel OF oDlg PIXEL 
    @ 014, 065 MSGET nPeso Size 55, 11 Pixel OF oDlg PIXEL picture '@E 999.99'

    @ 030, 058 SAY cIdade Size 55, 07 Pixel OF oDlg PIXEL 
    @ 038, 037 MSGET nIdade Size 55, 11 Pixel OF oDlg PIXEL picture "99"

    @ 055, 010 BUTTON oBtnConf PROMPT "Homem" Size 55, 20 PIXEL Of oDlg Action(nOpcao := 1, CalcTMB())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    @ 055, 065 BUTTON oBtnConf PROMPT "Mulher" Size 55, 20 PIXEL Of oDlg Action(nOpcao := 2, CalcTMB())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    @ 075, 010 BUTTON oBtnConf PROMPT "Fechar" Size 110, 15 PIXEL Of oDlg Action(oDlg:End())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    ACTIVATE MSDialog ODlg CENTERED
Return 

Static Function CalcTMB()
    Local nResult := 0
    if nOpcao == 1
        nResult := 66.5 + (13.75 * val(nPeso)) + (5.003 * val(nAltura)) - (6.75 * val(nIdade))
        FwAlertInfo("Resultado do TMB Masculino: " + CVALTOCHAR( nResult ), "Resultado Masculino")
    else
        nResult := 655.1 + (9.563 * val(nPeso)) + (1.850 * val(nAltura)) - (4.676 * val(nIdade))
        FwAlertInfo("Resultado do TMB Feminino: " + CVALTOCHAR( nResult ), "Resultado Feminino")
    endif 
Return 
