#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function PSAY1
    Exercicio numero 1 da lista 9
    @type  Function
    @author Lucas Leal
    @since 04/04/2023
    /*/
User Function PSAY1()
    Local cTitulo       := 'Cadastros de Produtos'
	Private cTamanho    := 'M'
	Private cNomeProg   := 'Impressão do primeiro exercicio' 
	Private aReturn     := {'Zebrado', 1, 'Administracao', 1, 2, '', '', 1}
	Private nLastKey    := 0
	Private cNomRel     := 'PSAY_Produtos' 
	Private cAlias 	    := 'SB1'
	//? Monta a interface padrao com o usuario...
	cNomRel := SetPrint(cAlias, cNomeProg, '', @cTitulo, '', '', '', .F.,, .T., cTamanho,, .F.)
	//? Se pressionar "ESC" encerra o programa
	if nLastKey == 27
		FwAlertError('Operação cancelada pelo usuário!', 'CANCELADO!')
		Return
	endif
	SetDefault(aReturn, cAlias,, .T., 1)
	RptStatus({|| Imprime(cTitulo)}, cTitulo)
Return 

Static Function Imprime(cTitulo)
    Local cTraco		 := '----------------------------------------'
	Local nLinha 		 := 2 
    Local cValor         := ''
	DbSelectArea('SB1')
	SB1->(DbSetOrder(1))
	//? Impressão dos dados
	while !Eof() 
        cValor := Alltrim(SB1->B1_PRV1)
        if cValor == ''
            cValor := '0,00'
        endif
		@ nLinha, 00 PSAY PADR('Código: ', 20) + Alltrim(SB1->B1_COD)
		@ ++nLinha, 00 PSAY PADR('Descrição: ', 20) + Alltrim(SB1->B1_DESC)
		@ ++nLinha, 00 PSAY PADR('Unidade de Medida: ', 20) + Alltrim(SB1->B1_UM)
		@ ++nLinha, 00 PSAY PADR('Preço de Venda: ', 20) + 'R$' + cValor
		@ ++nLinha, 00 PSAY PADR('Armazem: ', 20) + Alltrim(SB1->B1_LOCPAD)
		@ ++nLinha, 00 PSAY cTraco
        ++nLinha
		SB1->(dbSkip())
  enddo

	SET DEVICE TO SCREEN
	if aReturn[5] == 1
		SET PRINTER TO dbCommitAll()
		OurSpool(cNomRel) 
	endif
	MS_FLUSH()
Return
