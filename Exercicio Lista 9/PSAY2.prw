#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function PSAY
	Exemplo de relatùrio utilizando PSAY
	@type  Function
	@author Muriel Zounar
	@since 29/03/2023
	/*/
User Function PSAY2()        
	Local cTitulo       := 'Cadastros de Produtos'
	Private cTamanho    := 'M'
	Private cNomeProg   := 'PSAY2' //? Nome do programa para impressao no cabecalho
	Private aReturn     := {'Zebrado', 1, 'Administracao', 1, 2, '', '', 1}
	Private nLastKey    := 0
	Private cNomRel     := 'PSAY' //? Nome do arquivo usado para impressao em disco
	Private cAlias 	    := 'SB1'
	Private m_pag		:= 1

	//? Monta a interface padrao com o usuario...
	cNomRel := SetPrint(cAlias, cNomeProg, '', @cTitulo, '', '', '', .F.,, .T., cTamanho,, .F.)

	//? Se pressionar "ESC" encerra o programa
	if nLastKey == 27
		FwAlertError('Operaùùo cancelada pelo usuùrio!', 'CANCELADO!')
		Return
	endif

	//? Prepara o ambiente para impressùo
	SetDefault(aReturn, cAlias,, .T., 1)

	//? Processamento. RPTSTATUS monta janela com a regua de processamento.
	RptStatus({|| Imprime(cTitulo)}, cTitulo)
Return

Static Function Imprime(cTitulo)
	Local cCabec		 := ' CÛdigo     DescriÁ„o                       Un. Medida      PreÁo            ArmazÈm       '
    Local cTraco		 := '-------------------------------------------------------------------------------------------'
	Local nLinha 		 := 8 //? Linha em que a impressùo iniciarù
	Local aColunas	     := {}
	Local nCont			 := 0

	//? Colunas para impressùo
	Aadd(aColunas, 001)
	Aadd(aColunas, 012)
	Aadd(aColunas, 048)
	Aadd(aColunas, 060)
	Aadd(aColunas, 077)

	DbSelectArea('SB1')
	SB1->(DbSetOrder(1))

	//? Cabeùalho do Relatùrio
	Cabec(cTitulo, cCabec, '',, cTamanho)

	//? Impressùo dos dados de cada registro em linha
	while !Eof() 
		nCont++
		cValor := Alltrim(SB1->B1_PRV1)
		if cValor == ''
            cValor := '0,00'
        endif
		@ nLinha, aColunas[1] PSAY PADR(Alltrim(SB1->B1_COD),    10)
		@ nLinha, aColunas[2] PSAY PADR(Alltrim(SB1->B1_DESC),   50)
		@ nLinha, aColunas[3] PSAY PADR(Alltrim(SB1->B1_UM),     10)
		@ nLinha, aColunas[4] PSAY PADR(cValor,   10)
		@ nLinha, aColunas[5] PSAY PADR(Alltrim(SB1->B1_LOCPAD), 10)
		nLinha++
		@ nLinha,00 PSAY cTraco
		nLinha++
		
		SB1->(dbSkip())

		if nCont == 10
			nLinha := 8
		endif
  	enddo

	//? Finaliza a execucao do relatorio...
	SET DEVICE TO SCREEN

	//? Se impressao em disco, chama o gerenciador de impressao...
	if aReturn[5] == 1
		SET PRINTER TO dbCommitAll()
		OurSpool(cNomRel) //? Gerenciador de impressùo do Protheus
	endif

	//? Descarrega o spool de impressùo
	MS_FLUSH()
Return
      