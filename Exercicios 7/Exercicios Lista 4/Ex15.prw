#INCLUDE 'Totvs.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'TBICONN.CH'

User Function L04Ex15()
    Local cTitle := 'Pesquisa de produto'
    Private cChamaCod := "Cód:", cCodigo := SPACE( 6 )
    Private oBtnConf, oDlg
    Private cDescricao, nValorVenda, cCod

    Define MSDialog oDlg Title cTitle From 000,000 to 200,260 PIXEL

    @ 010, 010 SAY cChamaCod Size 55, 07 Pixel OF oDlg PIXEL
    @ 007, 030 MSGET oRet Var cCodigo Size 40, 11 Pixel OF oDlg PIXEL 

    @ 007, 075 BUTTON oBtnConf PROMPT "Buscar" Size 40, 13 PIXEL Of oDlg Action(BuscaCod())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    @ 033, 010 SAY "Código" Size 55, 07 Pixel OF oDlg PIXEL
    @ 030, 065 MSGET oRet Var cCod Size 55, 11 Pixel OF oDlg PIXEL 
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000;}")

    @ 048, 010 SAY oSay Var "Descrição " Size 55, 07 Pixel OF oDlg PIXEL
    @ 045, 065 MSGET oRet Var cDescricao Size 55, 11 Pixel OF oDlg PIXEL 
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000;}")

    @ 063, 010 SAY "Preço de venda" Size 55, 07 Pixel OF oDlg PIXEL
    @ 060, 065 MSGET oRet Var nValorVenda Size 55, 11 Pixel OF oDlg PIXEL PICTURE "R$ 999.99"
    oRet:lActive := .F.
    oRet:setCSS("QLineEdit{color:#000;}")

    @ 080, 010 BUTTON oBtnConf PROMPT "Fechar" Size 110, 15 PIXEL Of oDlg Action(oDlg:End())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    ACTIVATE MSDialog ODlg CENTERED 
Return 

Static Function BuscaCod()
    Local aArea  := GetArea()
    Local cAlias := GetNextAlias()
    Local cQuery := ''
    
    
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    cQuery := 'SELECT B1_COD, B1_DESC, B1_PRV1' + CRLF
    cQuery += 'FROM ' + RetSqlName('SB1') + ' SB1 ' + CRLF
    cQuery += "WHERE  D_E_L_E_T_ = ' ' " + CRLF
    cQuery += "AND B1_COD = '" + cCodigo + "'"  

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    cDescricao  := &(cAlias)->(B1_DESC)
    cCod  := &(cAlias)->(B1_COD)
    nValorVenda := &(cAlias)->(B1_PRV1)

    &(cAlias)->(DbSkip())


    if ALLTRIM(cCod) == cCodigo
        oRet:Refresh()
    else
        FwAlertError("O código " + cCodigo + " não consta no cadastro de produtos do sistema", "Código Inexistente")        
    endif
    &(cAlias)->(DbCloseArea())
  
    RestArea(aArea)
Return

