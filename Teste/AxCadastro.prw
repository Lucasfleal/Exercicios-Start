#INCLUDE 'PROTHEUS.CH'

User Function CadSA2()
    Local cAlias := 'SA2'
    Local cTitulo := 'Cadastro de Fornecedores'
    // Local lVldExc := 'U_VldExc()'

    DBSELECTAREA( cAlias )
    DBSETORDER( 1 )
    AxCadastro(CALIAS, cTitulo, 'U_VldExc()', NIL)
Return

User Function VldExc()
    Local cMsg := 'Confirma a exclusão do fornecedor ?'
    Local lRet := .F.

    lRet := MSGYESNO( cMsg, 'Tem certeza ?' )
Return lRet
