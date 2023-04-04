#INCLUDE 'TOTVS.CH'

User Function L05Ex16()
    Local cTitle := 'Boletim escolar'
    Private aBoletim := {}
    Private nJanAltu := 120
    Private nJanLarg := 260
    Private oBtnConf, oDlg, oGrp

    Define MSDialog oDlg Title cTitle From 000,000 to nJanAltu,nJanLarg PIXEL

    @ 003, 001     GROUP oGrp TO (nJanAltu/2)-1, (nJanLarg/2)-3         PROMPT "Informações de Alunos: "     OF oDlg COLOR 0, 16777215 PIXEL 

    @ 013, 010 BUTTON oBtnConf PROMPT "Adicionar Notas" Size 055, 15 PIXEL Of oDlg Action(AddNota())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    @ 013, 065 BUTTON oBtnConf PROMPT "Imprimir Notas" Size 055, 15 PIXEL Of oDlg Action(ImprimeNota())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    @ 033, 025 BUTTON oBtnConf PROMPT "Fechar" Size 080, 15 PIXEL Of oDlg Action(oDlg:End())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    ACTIVATE MSDialog oDlg CENTERED
Return

Static Function AddNota()
    Local cTitle := 'Inclusão de notas'
    Local cNome := SPACE(30)
    Local nNota1:= 00, nNota2:= 00,nNota3 := 00
    Local nI
    Private nJanAltu :=  200
    Private nJanLarg := 300
    Private oBtnConf, oDlgAdd, oGrpAdd
    aBoletim := {}

    FOR nI := 1 to 4
        Define MSDialog oDlgAdd Title cTitle From 000,000 to nJanAltu,nJanLarg PIXEL

        @ 003, 001     GROUP oGrpAdd TO (nJanAltu/2)-1, (nJanLarg/2)-3         PROMPT "Informações do Aluno " + cValToChar(nI)+ ": "     OF oDlgAdd COLOR 0, 16777215 PIXEL 
        
        @ 015, 020 SAY "Nome do aluno:" Size 55, 07 Pixel OF oDlgAdd PIXEL
        @ 012, 075 MSGET cNome          Size 55, 11 Pixel OF oDlgAdd PIXEL 

        @ 030, 020 SAY "Nota 1:"        Size 55, 07 Pixel OF oDlgAdd PIXEL
        @ 027, 075 MSGET nNota1         Size 55, 11 Pixel OF oDlgAdd PIXEL PICTURE "@E 99"

        @ 045, 020 SAY "Nota 2:"        Size 55, 07 Pixel OF oDlgAdd PIXEL
        @ 042, 075 MSGET nNota2         Size 55, 11 Pixel OF oDlgAdd PIXEL PICTURE "@E 99"

        @ 060, 020 SAY "Nota 3:"        Size 55, 07 Pixel OF oDlgAdd PIXEL
        @ 057, 075 MSGET nNota3         Size 55, 11 Pixel OF oDlgAdd PIXEL PICTURE "@E 99"

        @ 075, 025 BUTTON oBtnConf PROMPT "Salvar" Size 080, 15 PIXEL Of oDlgAdd Action(SalvaNota(@cNome, @nNota1, @nNota2,@nNota3),oDlgAdd:End())
        oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

        ACTIVATE MSDialog oDlgAdd CENTERED
    next
Return 

Static Function SalvaNota(cNome, nNota1, nNota2,nNota3)
    Local nMedia := (nNota1 + nNota2 + nNota3) / 3

    AADD( aBoletim, {cNome, nNota1, nNota2, nNota3, nMedia})
    cNome := SPACE(30)
    nNota1:= nNota2:= nNota3 := 00
Return 

Static Function ImprimeNota()
    Local cTitle := 'Imprime nota'
    Local nLinha := 15
    Private nJanAltu :=  180
    Private nJanLarg := 350
    Private oBtnConf, oDlgPrint, oGrpPrint,oRet

    Define MSDialog oDlgPrint Title cTitle From 000,000 to nJanAltu,nJanLarg PIXEL

    @ 003, 001     GROUP oGrpPrint TO (nJanAltu/2)-1, (nJanLarg/2)-3  PROMPT "Impressão Boletim"  OF oDlgPrint COLOR 0, 16777215 PIXEL 

    @ nLinha, 010 SAY "Nome do aluno" Size 55, 07 Pixel OF oDlgPrint PIXEL
    @ nLinha, 060 SAY "Nota 1"        Size 55, 07 Pixel OF oDlgPrint PIXEL
    @ nLinha, 090 SAY "Nota 2"         Size 55, 07 Pixel OF oDlgPrint PIXEL
    @ nLinha, 120 SAY "Nota 3"         Size 55, 07 Pixel OF oDlgPrint PIXEL
    @ nLinha, 150 SAY "Media"          Size 55, 07 Pixel OF oDlgPrint PIXEL

    nLinha += 12
 
    @ nLinha, 010 MSGET oRet Var alltrim(aBoletim[1][1])                 Size 55, 11 Pixel OF oDlgPrint PIXEL NO BORDER
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000; background-color:#CCC;}")
    @ nLinha, 064 MSGET oRet Var alltrim(str(aBoletim[1][2]))            Size 32, 11 Pixel OF oDlgPrint PIXEL NO BORDER
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000; background-color:#CCC;}")
    @ nLinha, 094 MSGET oRet Var alltrim(str(aBoletim[1][3]))            Size 32, 11 Pixel OF oDlgPrint PIXEL NO BORDER
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000; background-color:#CCC;}")
    @ nLinha, 124 MSGET oRet Var alltrim(str(aBoletim[1][4]))            Size 32, 11 Pixel OF oDlgPrint PIXEL NO BORDER
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000; background-color:#CCC;}")
    @ nLinha, 154 MSGET oRet Var alltrim(str(ROUND(aBoletim[1][5], 0)))  Size 10, 11 Pixel OF oDlgPrint PIXEL NO BORDER
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000; background-color:#CCC;}") 
    
    nLinha += 12

    @ nLinha, 010 MSGET oRet Var alltrim(aBoletim[2][1])                 Size 55, 11 Pixel OF oDlgPrint PIXEL NO BORDER
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000; background-color:#FEFEFE;}")
    @ nLinha, 064 MSGET oRet Var alltrim(str(aBoletim[2][2]))            Size 32, 11 Pixel OF oDlgPrint PIXEL NO BORDER
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000; background-color:#FEFEFE;}")
    @ nLinha, 094 MSGET oRet Var alltrim(str(aBoletim[2][3]))            Size 32, 11 Pixel OF oDlgPrint PIXEL NO BORDER
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000; background-color:#FEFEFE;}")
    @ nLinha, 124 MSGET oRet Var alltrim(str(aBoletim[2][4]))            Size 32, 11 Pixel OF oDlgPrint PIXEL NO BORDER
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000; background-color:#FEFEFE;}")
    @ nLinha, 154 MSGET oRet Var alltrim(str(ROUND(aBoletim[2][5], 0)))  Size 10, 11 Pixel OF oDlgPrint PIXEL NO BORDER
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000; background-color:#FEFEFE;}")
    
    nLinha += 12

    @ nLinha, 010 MSGET oRet Var alltrim(aBoletim[3][1])                 Size 55, 11 Pixel OF oDlgPrint PIXEL NO BORDER
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000; background-color:#CCC;}")
    @ nLinha, 064 MSGET oRet Var alltrim(str(aBoletim[3][2]))            Size 32, 11 Pixel OF oDlgPrint PIXEL NO BORDER
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000; background-color:#CCC;}")
    @ nLinha, 094 MSGET oRet Var alltrim(str(aBoletim[3][3]))            Size 32, 11 Pixel OF oDlgPrint PIXEL NO BORDER
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000; background-color:#CCC;}")
    @ nLinha, 124 MSGET oRet Var alltrim(str(aBoletim[3][4]))            Size 32, 11 Pixel OF oDlgPrint PIXEL NO BORDER
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000; background-color:#CCC;}")
    @ nLinha, 154 MSGET oRet Var alltrim(str(ROUND(aBoletim[3][5], 0)))  Size 10, 11 Pixel OF oDlgPrint PIXEL NO BORDER
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000; background-color:#CCC;}")
    
    nLinha += 12

    @ nLinha, 010 MSGET oRet Var alltrim(aBoletim[4][1])                 Size 55, 11 Pixel OF oDlgPrint PIXEL NO BORDER
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000; background-color:#FEFEFE;}")
    @ nLinha, 064 MSGET oRet Var alltrim(str(aBoletim[4][2]))            Size 32, 11 Pixel OF oDlgPrint PIXEL NO BORDER
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000; background-color:#FEFEFE;}")
    @ nLinha, 094 MSGET oRet Var alltrim(str(aBoletim[4][3]))            Size 32, 11 Pixel OF oDlgPrint PIXEL NO BORDER
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000; background-color:#FEFEFE;}")
    @ nLinha, 124 MSGET oRet Var alltrim(str(aBoletim[4][4]))            Size 32, 11 Pixel OF oDlgPrint PIXEL NO BORDER
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000; background-color:#FEFEFE;}")
    @ nLinha, 154 MSGET oRet Var alltrim(str(ROUND(aBoletim[4][5], 0)))  Size 10, 11 Pixel OF oDlgPrint PIXEL NO BORDER
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000; background-color:#FEFEFE;}")

    nLinha += 20

    @ nLinha, 025 BUTTON oBtnConf PROMPT "Salvar" Size 080, 15 PIXEL Of oDlgAdd Action(SalvaNota(@cNome, @nNota1, @nNota2,@nNota3),oDlgAdd:End())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")


    
    ACTIVATE MSDialog oDlgPrint CENTERED
Return 
