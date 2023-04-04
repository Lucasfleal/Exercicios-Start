#Include "Protheus.ch"

#DEFINE cUserName "LUCAS"
#DEFINE cSenha "123"
  
User Function L04Ex07()
    Local aArea := GetArea()
    Local oGrpLog
    Local oBtnConf
    Private oDlgPvt
    //Says e Gets
    Private oSayUsr
    Private oGetUsr, cGetUsr := Space(25)
    Private oSayPsw
    Private oGetPsw, cGetPsw := Space(20)
    Private oSayCfm
    Private oGetCfm, cGetCfm := Space(20)
    Private oGetErr, cGetErr := ""
    //Dimensões da janela
    Private nJanLarg := 200
    Private nJanAltu := 220
      
    //Criando a janela
    DEFINE MSDIALOG oDlg TITLE "Cadastro de Usuário" FROM 000, 000  TO nJanAltu, nJanLarg PIXEL
        //Grupo de Login
        @ 003, 001     GROUP oGrpLog TO (nJanAltu/2)-1, (nJanLarg/2)-3         PROMPT "Cadastro: "     OF oDlg COLOR 0, 16777215 PIXEL
            //Label e Get de Usuário
            @ 013, 006   SAY   oSayUsr PROMPT "Usuário:"        SIZE 030, 007 OF oDlg                   PIXEL
            @ 020, 006   MSGET oGetUsr VAR    cGetUsr           SIZE (nJanLarg/2)-12, 007 OF oDlg COLORS 0, 16777215 PIXEL
          
            //Label e Get da Senha
            @ 033, 006   SAY   oSayPsw PROMPT "Senha:"          SIZE 030, 007 OF oDlg                    PIXEL
            @ 040, 006   MSGET oGetPsw VAR    cGetPsw           SIZE (nJanLarg/2)-12, 007 OF oDlg COLORS 0, 16777215 PIXEL PASSWORD

            @ 053, 006   SAY   oSayCfm PROMPT "Confirme a senha:"          SIZE 030, 007 OF oDlg                    PIXEL
            @ 060, 006   MSGET oGetCfm VAR    cGetCfm           SIZE (nJanLarg/2)-12, 007 OF oDlg COLORS 0, 16777215 PIXEL PASSWORD
          
            //Get de Log, pois se for Say, não da para definir a cor
            @ 080, 006   MSGET oGetErr VAR    cGetErr        SIZE (nJanLarg/2)-12, 007 OF oDlg COLORS 0, 16777215 NO BORDER PIXEL
            oGetErr:lActive := .F.
            oGetErr:setCSS("QLineEdit{color:#FF0000; background-color:#FEFEFE;}")
          
            //Botões
            @ (nJanAltu/2)-18, 006 BUTTON oBtnConf PROMPT "Confirmar"             SIZE (nJanLarg/2)-12, 015 OF oDlg ACTION (ValidaCadastro()) PIXEL
            oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")
    ACTIVATE MSDIALOG oDlg CENTERED
    RestArea(aArea)
Return 

Static Function ValidaCadastro()
    Private lVSimbolo := .F., lVUpper := .F., lVNum := .F.

    if len(alltrim(cGetUsr)) > 5
        if len(alltrim(cGetPsw)) > 5
            ValidaSenha()

            if lVSimbolo .AND. lVUpper .AND. lVNum
                if alltrim(cGetCfm) == alltrim(cGetPsw)
                    FwAlertSuccess("Cadastrado com Sucesso!", "Sucesso!")
                    oDlg:end()
                else
                    cGetErr := "Senhas estão diferentes!"
                    FwAlertError("As senhas não são iguais", "Senhas não são iguais")
                      oGetErr:Refresh()
                endif
            else
                ErroSenha()
            endif
        else
            ErroSenha()
        endif
    else
        cGetErr := "Usuário inválido!"
        FwAlertError("O usuário deve possuir mais do que 5 caracteres!", "Usuário inválido")
        oGetErr:Refresh()
    endif
Return

Static Function ValidaSenha()
    Local nCont := 1, cTempChar := ''
    
    while (nCont < len(cGetPsw)) .AND. (!lVSimbolo .Or. (!lVUpper .Or. !lVNum))
        cTempChar := upper(SUBSTR(cGetPsw, nCont, 1)) 

        if  (ASC(cTempChar) >= 33 .AND.  ASC(cTempChar) <= 46) .Or. (ASC(cTempChar) >= 58 .AND.  ASC(cTempChar) <= 64) .Or. ;
            (ASC(cTempChar) >= 91 .AND.  ASC(cTempChar) <= 95) .Or. (ASC(cTempChar) >= 123 .AND.  ASC(cTempChar) <= 126) 
            lVSimbolo := .T. 
        elseif (ASC(cTempChar) >= 65 .AND.  ASC(cTempChar) <= 90)
            lVUpper := .T.
        elseif ISDIGIT(cTempChar)
            lVNum := .T.
        endif

        nCont++
    end
Return 

Static Function ErroSenha()
    cGetErr := "Senha inválida!"
    FwAlertError("A Senha deve possuir mais do que 5 caracteres e conter:" + CRLF;
                + "Uma letra maiúscula" + CRLF;
                + "Um digito numérico" + CRLF;
                + "Um Símbolo", "Senha inválida")
    oGetErr:Refresh()
Return 
