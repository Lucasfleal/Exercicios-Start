#INCLUDE 'TOTVS.CH'

User Function L05Ex01()
    Local cTitle := 'Dias da Semana'
    Private nJanAltu :=  180
    Private nJanLarg := 260
    Private cSayDia := "Digite o dia: ", nDiaSemana := 0
    Private nRetorno := SPACE( 15 ), cResultado := "Resultado: "
    Private oRet, oBtnConf, oDlg, oGrpGet, oGrpRet
    
    Define MSDialog oDlg Title cTitle From 000,000 to 180,260 PIXEL
 
    //Grupo de solicitação de dados
    @ 003, 001     GROUP oGrpGet TO (nJanAltu/4)-1, (nJanLarg/2)-3         PROMPT "Solicitação: "     OF oDlg COLOR 0, 16777215 PIXEL 

        @ 014, 010 SAY cSayDia Size 55, 07 Pixel OF oDlg PIXEL
        @ 011, 065 MSGET nDiaSemana Size 55, 11 Pixel OF oDlg PIXEL 

        @ 025, 025 BUTTON oBtnConf PROMPT "Buscar" Size 080, 15 PIXEL Of oDlg Action(ConsultaSemana())
        oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    //Grupo de Retorno
    @ 045, 001  GROUP oGrpRet TO (nJanAltu/2)-1, (nJanLarg/2)-3         PROMPT "Retorno: "     OF oDlg COLOR 0, 16777215 PIXEL

        @ 060, 010 SAY cResultado Size 55, 07 Pixel OF oDlg PIXEL
        @ 057, 065 MSGET oRet Var nRetorno Size 55, 11 Pixel OF oDlg PIXEL NO BORDER 
        oRet:lActive := .F.
        oRet:setCSS("QLineEdit{color:#000; background-color:#FEFEFE;}")

        @ 070, 025 BUTTON oBtnConf PROMPT "Fechar" Size 080, 15 PIXEL Of oDlg Action(oDlg:End())
        oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")


    ACTIVATE MSDialog ODlg CENTERED
Return

Static Function ConsultaSemana()
    Local aDiaSemana := {'Domingo', 'Segunda-Feira', 'Terça-Feira', 'Quarta-Feira', 'Quinta-Feira', 'Sexta-Feira', 'Sábado'}

    if nDiaSemana > 7 .OR. nDiaSemana < 1
        FwAlertError("Numero digitado não corresponde a um dia da semana", "Numero incorreto")        
    else
        nRetorno := aDiaSemana[nDiaSemana]
    endif

    oRet:Refresh()
Return 
