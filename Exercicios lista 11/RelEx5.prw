#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'RPTDEF.CH'
#INCLUDE 'FWPRINTSETUP.CH'

#DEFINE PRETO    RGB(000, 000, 000)
#DEFINE VERMELHO RGB(255, 000, 000)

/*/{Protheus.doc} User Function RelEx1
    Relatorio criado para o exercicio 1 da lista 12.
    @type  Function
    @author user
    @since 17/04/2023
    /*/
User Function RELEX5()
    Local cAlias := GeraAlias()

    if !Empty(cAlias)
	    Processa({|| MontaRel(cAlias)}, 'Aguarde...', 'O relatório está sendo gerado', .F.)
    else    
        FwAlertError('Nenhum Registro encontrado!', 'Atenção')
    endif
Return

Static Function GeraAlias()
    Local aArea  := GetArea()
	Local cAlias := GetNextAlias()
	Local cQuery := ''
	cQuery := 'SELECT C7_NUM,'  + CRLF
    cQuery += 'C7_PRODUTO,'     + CRLF
    cQuery += 'C7_DESCRI,'      + CRLF
    cQuery += 'C7_ITEM, '       + CRLF
    cQuery += 'C7_QUANT,'       + CRLF 
    cQuery += 'C7_PRECO,'       + CRLF
    cQuery += 'C7_TOTAL,'       + CRLF
    cQuery += 'C7_LOJA,'        + CRLF
    cQuery += 'C7_EMISSAO, '    + CRLF
    cQuery += 'E4_DESCRI, '     + CRLF
    cQuery += 'A2_NREDUZ'       + CRLF	
    cQuery += 'FROM ' + RetSqlName('SC7') + ' SC7' + CRLF
	cQuery += 'INNER JOIN ' + RetSqlName('SA2') + ' A2 ON A2_COD = C7_FORNECE' + CRLF
	cQuery += 'LEFT JOIN ' + RetSqlName('SE4') + ' E4 ON C7_COND = E4_CODIGO' + CRLF
	cQuery += "WHERE SC7.D_E_L_E_T_ = ' '" + CRLF
    cQuery += "ORDER BY C7_NUM"
	TCQUERY cQuery ALIAS (cAlias) NEW
	(cAlias)->(DbGoTop())
	if (cAlias)->(EOF())
		cAlias := ''
	endif
	RestArea(aArea)
Return cAlias

Static Function MontaRel(cAlias)
    Local cCamPDF := 'C:\Users\Lucas Leal\Desktop\PDFs\'
    Local cArqPDF := 'PedCompraGeral.pdf'
    Private nLinha   := 105
    Private nLinhaTot   := 800
    Private oPrint

    //? Criação de fontes a ser utilizada
    Private oFont08  := TFont():New('Arial',/*Compat.*/, 08 /*Tamanho*/, /*Compat.*/, .F. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .F./*Sublinhado*/, .F./*Itlico*/)
    Private oFont10  := TFont():New('Arial',/*Compat.*/, 10 /*Tamanho*/, /*Compat.*/, .F. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .F./*Sublinhado*/, .F./*Itlico*/)
    Private oFont12  := TFont():New('Arial',/*Compat.*/, 12 /*Tamanho*/, /*Compat.*/, .T. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .F./*Sublinhado*/, .F./*Itlico*/)
    Private oFont14  := TFont():New('Arial',/*Compat.*/, 14 /*Tamanho*/, /*Compat.*/, .T. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .F./*Sublinhado*/, .F./*Itlico*/)
    Private oFont16  := TFont():New('Arial',/*Compat.*/, 16 /*Tamanho*/, /*Compat.*/, .T. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .T./*Sublinhado*/, .F./*Itlico*/)

    Processa({|| }, 'Aguarde...', 'Criando Relatorio...', .F.)
    oPrint := FWMSPrinter():New(cArqPDF, IMP_PDF, .F., '', .T.,, @oPrint, '',,,, .T.)
    oPrint:cPathPDF := cCamPDF

    oPrint:SetPortrait()
    oPrint:setPaperSize(9)
    oPrint:StartPage()
    Cabecalho()
    ImpDados(cAlias)
    oPrint:endPage()
    oPrint:Preview()
Return 

Static Function Cabecalho()
    Local cLogo := ('D:\TOTVS12\Protheus\protheus_data\system\LGRL' + SM0->M0_CODIGO + '.png')
    
    Processa({|| }, 'Aguarde...', 'Imprimindo Cabeçalho...', .F.)

    //? Criando caixa que vai estar o cabeçalho da pagina
    oPrint:Box(15, 15, 85, 580, '-8')
    oPrint:Line(50, 100, 50, 580, /*Cor*/, '-6')
    oPrint:SayBitMap(20, 20, cLogo, 70, 65)
    oPrint:Line(15, 100, 85, 100)

    oPrint:Say(35, 110, 'Empresa / Filial: ' + AllTrim(SM0->M0_NOME) + ' / ' + AllTrim(SM0->M0_FILIAL), oFont14,, PRETO)
    oPrint:Say(70, 280, 'Pedidos de Compra', oFont16,, PRETO)
    
    //? Pedido
	oPrint:Say(nLinha     ,  20, 'Nº Pedido: '          , oFont12,, PRETO )
	oPrint:Say(nLinha     , 270, 'Data de Emissão: '    , oFont12,, PRETO )
	oPrint:Say(nLinha+= 15,  20, 'Fornecedor: '         , oFont12,, PRETO )
	oPrint:Say(nLinha     , 326, 'Loja: '               , oFont12,, PRETO )
	oPrint:Say(nLinha+= 15,  20, 'Pagamento: '          , oFont12,, PRETO )
	//? Itens do Pedido 
	oPrint:Box(nLinha+=20 ,   15, 560,580, '-8')
	oPrint:Say(nLinha+= 10,  20, 'Item'                 , oFont12,, PRETO )
	oPrint:Say(nLinha     ,  64, 'Produto'              , oFont12,, PRETO )
	oPrint:Say(nLinha     , 150, 'Descrição do Produto' , oFont12,, PRETO )
	oPrint:Say(nLinha     , 320, 'Qtd.'                 , oFont12,, PRETO )
	oPrint:Say(nLinha     , 390, 'Prc Unit.'            , oFont12,, PRETO )
	oPrint:Say(nLinha     , 490, 'Prc Total.'           , oFont12,, PRETO )
    
    nLinha += 5

    //? SEPARAÇÃO CABEÇALHO E PRODUTOS
    oPrint:Line(nLinha, 015, nLinha, 580,, '-6')

    nLinha += 20 

    oPrint:Line(540,15,540,580,,'-6')
    oPrint:Say(554, 370, 'Valor Total: ', oFont14,, PRETO)
Return

Static Function ImpDados(cAlias)
    Local nTotal := 0
    local cPedido    := ''
    Private lPage      := .f.
    Private nQtdPagina   := 1

    DbSelectArea(cAlias)

    (cAlias)->(DbGoTop())

    while (cAlias)->(!EOF())
        if cPedido <> Alltrim((cAlias)->(C7_NUM))
            VeriQuebPg(nTotal)
            nLinha := 105
            oPrint:Say(nLinha    ,   74, (cAlias)->(C7_NUM),                 oFont10,, PRETO)
            oPrint:Say(nLinha    ,  360, Dtoc(Stod((cAlias)->(C7_EMISSAO))), oFont10,, PRETO)
            oPrint:Say(nLinha+=15,   80, (cAlias)->(A2_NREDUZ),              oFont10,, PRETO)
            oPrint:Say(nLinha    ,  360, (cAlias)->(C7_LOJA),                oFont10,, PRETO)
            oPrint:Say(nLinha+=15,   80, (cAlias)->(E4_DESCRI),              oFont10,, PRETO)
            nLinha+=45
            cPedido := Alltrim((cAlias)->(C7_NUM))
            nTotal := 0
        endif

        nTotal += (cAlias)->(C7_TOTAL)
        Processa({|| }, 'Aguarde...', 'Imprimindo Produtos...', .F.)

		//imprimindo os itens
		oPrint:Say(nLinha,  20, (cAlias)->(C7_ITEM)   , oFont10,, PRETO)
		oPrint:Say(nLinha,  64, (cAlias)->(C7_PRODUTO), oFont10,, PRETO)
		oPrint:Say(nLinha, 150, (cAlias)->(C7_DESCRI) , oFont10,, PRETO)
		oPrint:Say(nLinha, 326, cValToChar((cAlias)->(C7_QUANT)), oFont10,, PRETO)
		oPrint:Say(nLinha, 392, 'R$' + STRTRAN(STR((cAlias)->(C7_PRECO),7,2), ".", ","), oFont10,, PRETO)
		oPrint:Say(nLinha, 493, 'R$' + STRTRAN(STR((cAlias)->(C7_TOTAL),7,2), ".", ","), oFont10,, PRETO)
		nLinha += 15
		(cAlias)->(DbSkip())
	enddo

    oPrint:Say(554, 493, 'R$' + STRTRAN(STR(nTotal,7,2), ".", ","), oFont12,, PRETO)

    (cAlias)->(DbCloseArea())
Return

Static Function VeriQuebPg(nTotal)
    if lPage
        oPrint:Say(554, 493, 'R$' + STRTRAN(STR(nTotal,7,2), ".", ","), oFont12,, PRETO)

        oPrint:EndPage()
        oPrint:StartPage()

        nQtdPagina++
        nLinha := 105
        
        Cabecalho()
    else
        lPage := .T.
    endif
    Processa({||}, 'Aguarde...', 'Imprimindo Dados da pagina ' + AllTrim(CVALTOCHAR(nQtdPagina)) + '...', .F.)
Return
