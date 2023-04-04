#INCLUDE 'Totvs.CH'

User Function L04Ex10()
    Local cTitle := 'Folha de Pagamento'
    Private cValorHora := "Valor Hora:", nValorHora := SPACE( 7 )
    Private cQtdHora := "Horas Trabalhadas: ", nQtdHora := SPACE( 7 )
    Private oBtnConf, oDlg
    Private nSalBruto, nIR, nINSS, nFGTS, cPorcIR := '', nTotDesc, nTotLiq

    Define MSDialog oDlg Title cTitle From 000,000 to 320,260 PIXEL

    @ 007, 026 SAY cValorHora Size 55, 07 Pixel OF oDlg PIXEL
    @ 014, 010 MSGET oRet Var nValorHora Size 55, 11 Pixel OF oDlg PIXEL 

    @ 007, 068 SAY cQtdHora Size 55, 07 Pixel OF oDlg PIXEL
    @ 014, 065 MSGET oRet Var nQtdHora Size 55, 11 Pixel OF oDlg PIXEL 

    @ 033, 010 SAY "Salário Bruto" Size 55, 07 Pixel OF oDlg PIXEL
    @ 030, 065 MSGET oRet Var nSalBruto Size 55, 11 Pixel OF oDlg PIXEL PICTURE "R$ 999,999.99"
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000;}")

    @ 048, 010 SAY oSay Var "(-) IR " + cPorcIR Size 55, 07 Pixel OF oDlg PIXEL
    @ 045, 065 MSGET oRet Var nIR Size 55, 11 Pixel OF oDlg PIXEL PICTURE "R$ 999999.99"
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000;}")

    @ 063, 010 SAY "(-) INSS (10%)" Size 55, 07 Pixel OF oDlg PIXEL
    @ 060, 065 MSGET oRet Var nINSS Size 55, 11 Pixel OF oDlg PIXEL PICTURE "R$ 999999.99"
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000;}")

    @ 078, 010 SAY "FGTS (11%)" Size 55, 07 Pixel OF oDlg PIXEL
    @ 075, 065 MSGET oRet Var nFGTS Size 55, 11 Pixel OF oDlg PIXEL PICTURE "R$ 999999.99"
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000;}")

    @ 093, 010 SAY "Total de descontos" Size 55, 07 Pixel OF oDlg PIXEL
    @ 090, 065 MSGET oRet Var nTotDesc Size 55, 11 Pixel OF oDlg PIXEL PICTURE "R$ 999999.99"
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000;}")

    @ 108, 010 SAY "Salário Liquido" Size 55, 07 Pixel OF oDlg PIXEL
    @ 105, 065 MSGET oRet Var nTotLiq Size 55, 11 Pixel OF oDlg PIXEL PICTURE "R$ 999,999.99"
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000;}")

    @ 125, 010 BUTTON oBtnConf PROMPT "Calcular" Size 110, 20 PIXEL Of oDlg Action(CalcFolha())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    @ 145, 010 BUTTON oBtnConf PROMPT "Fechar" Size 110, 15 PIXEL Of oDlg Action(oDlg:End())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    ACTIVATE MSDialog ODlg CENTERED 
Return 

Static Function CalcFolha()
    if val(nValorHora) == 0 .Or. val(nQtdHora) == 0
        FwAlertError("Não foram digitados todos os valores", "Campos Obrigatórios")
        Return
    endif

    nSalBruto := val(nValorHora) * val(nQtdHora)
    nIR := CalcIR()
    nINSS := nSalBruto * 0.1
    nFGTS := nSalBruto * 0.11
    nTotDesc := nIR + nINSS
    nTotLiq := nSalBruto - nTotDesc

    nValorHora := nQtdHora := SPACE( 7 )
    oRet:Refresh()
    oSay:Refresh()
Return 

Static Function CalcIR()
    Local nTempVar := 0

    if nSalBruto <= 1200
        cPorcIR := "(Isento)"
        nTempVar := 0
    elseif nSalBruto > 1200 .AND. nSalBruto <= 1800
        cPorcIR := "(5%)"
        nTempVar := nSalBruto * 0.05
    elseif nSalBruto > 1800 .AND. nSalBruto <= 2500
        cPorcIR := "(10%)"
        nTempVar := nSalBruto * 0.1
    elseif nSalBruto > 2500
        cPorcIR := "(20%)"
        nTempVar := nSalBruto * 0.2
    endif

Return nTempVar
