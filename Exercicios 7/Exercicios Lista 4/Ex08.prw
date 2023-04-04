#INCLUDE 'Totvs.CH'

User Function L04Ex08()
    Local cTitle := 'Calculo de IMC'
    Private cPeso := "Peso:", nPeso := SPACE( 15 )
    Private cAltura := "Altura: ", nAltura := SPACE( 15 )
    Private oBtnConf, oDlg

    Define MSDialog oDlg Title cTitle From 000,000 to 180,260 PIXEL

    @ 007, 026 SAY cAltura Size 55, 07 Pixel OF oDlg PIXEL
    @ 014, 010 MSGET nAltura Size 55, 11 Pixel OF oDlg PIXEL 

    @ 007, 080 SAY cPeso Size 55, 07 Pixel OF oDlg PIXEL
    @ 014, 065 MSGET nPeso Size 55, 11 Pixel OF oDlg PIXEL 

    @ 050, 010 BUTTON oBtnConf PROMPT "Calcular" Size 110, 20 PIXEL Of oDlg Action(CalcIMC())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    @ 070, 010 BUTTON oBtnConf PROMPT "Fechar" Size 110, 15 PIXEL Of oDlg Action(oDlg:End())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    ACTIVATE MSDialog ODlg CENTERED
Return 

Static Function CalcIMC()
    Local nTempVal := val(nPeso) / (val(nAltura) ** 2)
    
    if nTempVal < 18.5
        FwAlertInfo("Magreza - Obesidade (Grau): 0" ,"Precisa ganhar uns quilinhos" )
    elseif nTempVal >= 18.5 .and. nTempVal < 25
        FwAlertInfo("Normal - Obesidade (Grau): 0" ,"Nem muito, nem pouco, o ideal!" )
    elseif nTempVal >= 25 .and. nTempVal < 30
        FwAlertInfo("Sobrepeso - Obesidade (Grau): I" ,"Pouca coisa, mas é bom ir na academia!" )
    elseif nTempVal >= 30 .and. nTempVal < 40
        FwAlertInfo("Obesidade - Obesidade (Grau): II" ,"Cuidado! Sua saúde corre perigo!" )
    elseif nTempVal >= 40
        FwAlertInfo("Obesidade Grave - Obesidade (Grau): III" ,"PERIGO!! Procure um medico!!" )
    endif

Return 
