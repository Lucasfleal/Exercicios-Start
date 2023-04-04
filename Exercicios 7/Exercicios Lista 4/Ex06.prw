#Include "Protheus.ch"

#DEFINE cUserName "LUCAS"
#DEFINE cSenha "123"
  
User Function L04Ex06()
    Local aArea := GetArea()
    Local oGrpLog
    Local oBtnConf
    Private oDlgPvt
    //Says e Gets
    Private oSayUsr
    Private oGetUsr, cGetUsr := Space(25)
    Private oSayPsw
    Private oGetPsw, cGetPsw := Space(20)
    Private oGetErr, cGetErr := ""
    //Dimensões da janela
    Private nJanLarg := 200
    Private nJanAltu := 200
      
    //Criando a janela
    DEFINE MSDIALOG oDlg TITLE "Login" FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL
        //Grupo de Login
        @ 003, 001     GROUP oGrpLog TO (nJanAltu/2)-1, (nJanLarg/2)-3         PROMPT "Login: "     OF oDlg COLOR 0, 16777215 PIXEL
            //Label e Get de Usuário
            @ 013, 006   SAY   oSayUsr PROMPT "Usuário:"        SIZE 030, 007 OF oDlg                   PIXEL
            @ 020, 006   MSGET oGetUsr VAR    cGetUsr           SIZE (nJanLarg/2)-12, 007 OF oDlg COLORS 0, 16777215 PIXEL
          
            //Label e Get da Senha
            @ 033, 006   SAY   oSayPsw PROMPT "Senha:"          SIZE 030, 007 OF oDlg                    PIXEL
            @ 040, 006   MSGET oGetPsw VAR    cGetPsw           SIZE (nJanLarg/2)-12, 007 OF oDlg COLORS 0, 16777215 PIXEL PASSWORD
          
            //Get de Log, pois se for Say, não da para definir a cor
            @ 060, 006   MSGET oGetErr VAR    cGetErr        SIZE (nJanLarg/2)-12, 007 OF oDlg COLORS 0, 16777215 NO BORDER PIXEL
            oGetErr:lActive := .F.
            oGetErr:setCSS("QLineEdit{color:#FF0000; background-color:#FEFEFE;}")
          
            //Botões
            @ (nJanAltu/2)-18, 006 BUTTON oBtnConf PROMPT "Confirmar"             SIZE (nJanLarg/2)-12, 015 OF oDlg ACTION (ValidaUser()) PIXEL
            oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")
    ACTIVATE MSDIALOG oDlg CENTERED
    RestArea(aArea)
Return 

Static Function ValidaUser()
      
    If upper(ALLTRIM(cGetUsr)) == cUserName
        if alltrim(cGetPsw) == cSenha
            FwAlertSuccess('Login realizado com sucesso', "Sucesso!" )
            oDlg:End()
        Else
            cGetErr := "Usuário e/ou senha inválidos!"
            oGetErr:Refresh()
        ENDIF
        
    Else
         cGetErr := "Usuário e/ou senha inválidos!"
         oGetErr:Refresh()
    EndIf
Return
