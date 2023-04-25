#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'RPTDEF.CH'
#INCLUDE 'FWPRINTSETUP.CH'

#DEFINE PRETO    RGB(000, 000, 000)
#DEFINE VERMELHO RGB(255, 000, 000)

/*/{Protheus.doc} User Function L13_C1
    Relatorio criado para o  Challange da lista 13
    @type  Function
    @author Lucas Leal
    @since 24/04/2023
    /*/
User Function L13_C1()
    Local cTempLog := ''
    Local cAlias := GeraAlias(@cTempLog)
    Private cArqLog := cTempLog

    if !Empty(cAlias)
	    Processa({|| MontaRel(cAlias)}, 'Aguarde...', 'O relatorio está sendo gerado', .F.)
    else    
        FwAlertError('Nenhum Registro encontrado!', 'Atenção')
    endif
Return

Static Function GeraAlias(cArqLog)
    Local aArea  := GetArea()
	Local cAlias := GetNextAlias()
	Local cQuery := ''

    cArqLog += FWTimeStamp(2) + '  Gerando base Alias -- Processando' + CRLF

	cQuery := 'SELECT SC5.C5_NUM, SC5.C5_FRETE, SC5.C5_DESPESA, SC5.C5_CONDPAG,SC5.C5_TRANSP, SC5.C5_TPFRETE,SC5.C5_ESPECI1, SC5.C5_VOLUME1, SC5.C5_DESC1, SC5.C5_DESC2, SC5.C5_DESC3, SC5.C5_DESC4, SC5.C5_MENNOTA,' + CRLF
	cQuery += 'SA1.A1_NOME, SA1.A1_HPAGE,SA1.A1_EMAIL, SA1.A1_CONTATO,SA1.A1_END, SA1.A1_BAIRRO, SA1.A1_MUN, SA1.A1_CEP, SA1.A1_DDD, SA1.A1_TEL, SA1.A1_FAX, SA1.A1_CGC, SA1.A1_INSCR,' + CRLF
	cQuery += 'SE4.E4_DESCRI, SE4.E4_CODIGO,' + CRLF
	cQuery += 'SC6.C6_ITEM, SC6.C6_PRODUTO, SC6.C6_DESCRI, SC6.C6_UM, SC6.C6_QTDVEN, SC6.C6_PRCVEN, SC6.C6_VALOR, SC6.C6_IPIDEV, SC6.C6_ENTREG, SC6.C6_DTVALID,' + CRLF
	cQuery += 'SA4.A4_NOME,' + CRLF
	cQuery += 'SA3.A3_NOME FROM ' +  RetSqlName('SC5') + ' SC5' + CRLF
	cQuery += 'INNER JOIN ' + RetSqlName('SA1') + ' SA1 ON SA1.A1_COD = SC5.C5_CLIENTE' + CRLF
	cQuery += 'INNER JOIN ' + RetSqlName('SE4') + ' SE4 ON SE4.E4_CODIGO = SC5.C5_CONDPAG' + CRLF
	cQuery += 'INNER JOIN ' + RetSqlName('SC6') + ' SC6 ON SC6.C6_NUM = SC5.C5_NUM' + CRLF
	cQuery += 'LEFT JOIN '  + RetSqlName('SA4') + ' SA4 ON SA4.A4_COD = SC5.C5_TRANSP' + CRLF
	cQuery += 'LEFT JOIN '  + RetSqlName('SA3') + ' SA3 ON SA3.A3_COD = SC5.C5_VEND1' + CRLF
	cQuery += "WHERE SC5.D_E_L_E_T_ = ' ' AND SC5.C5_NUM = '" + M->C5_NUM + "'"
	TCQUERY cQuery ALIAS (cAlias) NEW
    cArqLog += FWTimeStamp(2) + '  Gerando base Alias -- Concluido' + CRLF
	(cAlias)->(DbGoTop())
	if (cAlias)->(EOF())
		cAlias := ''
        cArqLog += FWTimeStamp(2) + '  Gerando base Alias -- Consulta Vazia' + CRLF
	endif
	RestArea(aArea)
Return cAlias

Static Function MontaRel(cAlias)
    Local cArqPDF := M->C5_NUM + '.pdf'
    Private cCaminho := 'D:\TOTVS12\Protheus\protheus_data\' + CriaPasta()
    Private nLinha   := 125
    Private nLinhaTot   := 800
    Private oPrint

    //? Criação de fontes 
    Private oFont08  := TFont():New('Arial',/*Compat.*/, 08 /*Tamanho*/, /*Compat.*/, .F. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .F./*Sublinhado*/, .F./*Itï¿½lico*/)
    Private oFont10  := TFont():New('Arial',/*Compat.*/, 10 /*Tamanho*/, /*Compat.*/, .F. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .F./*Sublinhado*/, .F./*Itï¿½lico*/)
    Private oFont12  := TFont():New('Arial',/*Compat.*/, 12 /*Tamanho*/, /*Compat.*/, .T. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .F./*Sublinhado*/, .F./*Itï¿½lico*/)
    Private oFont14  := TFont():New('Arial',/*Compat.*/, 14 /*Tamanho*/, /*Compat.*/, .T. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .F./*Sublinhado*/, .F./*Itï¿½lico*/)
    Private oFont16  := TFont():New('Arial',/*Compat.*/, 16 /*Tamanho*/, /*Compat.*/, .T. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .T./*Sublinhado*/, .F./*Itï¿½lico*/)
    
    cArqLog += FWTimeStamp(2) + '  Criadas os fontes utilizadas no relatorio' + CRLF

    Processa({|| }, 'Aguarde...', 'Criando Relatorio...', .F.)
    cArqLog += FWTimeStamp(2) + '  Definindo caminho e nome do arquivo PDF' + CRLF
    oPrint := FWMSPrinter():New(cArqPDF, IMP_PDF, .F., '', .T.,, @oPrint, '',,,, .F.)
    oPrint:cPathPDF := cCaminho

    cArqLog += FWTimeStamp(2) + '  Configurando relatorio' + CRLF
    oPrint:SetPortrait()
    oPrint:setPaperSize(9)
    oPrint:StartPage()
    Cabecalho()
    ImpDados(cAlias)
    oPrint:endPage()
    cArqLog += FWTimeStamp(2) + '  Imprimindo relatorio' + CRLF
    oPrint:Preview()
    cArqLog += FWTimeStamp(2) + '  Relatorio Impresso' + CRLF
    CriaLog()
Return 

Static Function Cabecalho()
    Local cLogo := ('D:\TOTVS12\Protheus\protheus_data\system\LGRL' + SM0->M0_CODIGO + '.png')
    cArqLog += FWTimeStamp(2) + '  Adicionando o cabeçalho' + CRLF
    Processa({|| }, 'Aguarde...', 'Imprimindo Cabeçalho...', .F.)

    //? INFORMAÇÕES EMPRESA
    cArqLog += FWTimeStamp(2) + '  Adicionando informações da empresa' + CRLF
	oPrint:SayBitMap(20,20,cLogo, 70,65)

	oPrint:Say(35,409,  Alltrim(SM0->M0_NOMECOM), oFont16,, PRETO)
	oPrint:Say(45,456, 'Empresa/Filial: ' + Alltrim(SM0->M0_NOME) + ' / ' + Alltrim(SM0->M0_FILIAL), oFont10,, PRETO)
	oPrint:Say(55,421,  Alltrim(SM0->M0_ENDENT) + " " + Alltrim(SM0->M0_CIDENT) + "/" + Alltrim(SM0->M0_ESTENT) + ' ' + Alltrim(Transform(SM0->M0_CEPENT, '@e 99999-999')), oFont10,, PRETO)
	oPrint:Say(65,478, 'CNPJ:' +  Alltrim(Transform(SM0->M0_CGC, '@R 99.999.999/9999-99')), oFont10,, PRETO)
	oPrint:Say(75,513, 'Fone: ' +  Alltrim(SM0->M0_TEL), oFont10,, PRETO)

	oPrint:Line(85,15,85,580,,'-6')
	oPrint:Say(100,20, 'Pedido de Venda Nº ' + Alltrim(M->C5_NUM),oFont16,, PRETO)
	oPrint:Say(100,480,'Data: ' + Transform(Date(), '@E 99/99/9999'),oFont16,, PRETO)
	oPrint:Line(105,15,105,580,,'-6')

    //? DADOS CLIENTE
    cArqLog += FWTimeStamp(2) + '  Criando Cabeçalho do cliente '+ CRLF
	oPrint:Say(nLinha     ,  20, 'Cliente   : '  , oFont12,, PRETO )
	oPrint:Say(nLinha     , 270, 'Site      : '  , oFont12,, PRETO )
	oPrint:Say(nLinha+=15 ,  20, 'E-mail    : '  , oFont12,, PRETO )
	oPrint:Say(nLinha     , 270, 'Contato: '  , oFont12,, PRETO )
	oPrint:Say(nLinha+=15 ,  20, 'Endereço: '  , oFont12,, PRETO )
	oPrint:Say(nLinha     , 270, 'Bairro    : '  , oFont12,, PRETO )
	oPrint:Say(nLinha+=15 ,  20, 'Cidade    : '  , oFont12,, PRETO )
	oPrint:Say(nLinha     , 270, 'CEP       : '  , oFont12,, PRETO )
	oPrint:Say(nLinha+=15 ,  20, 'Tel         : '  , oFont12,, PRETO )
	oPrint:Say(nLinha     , 270, 'FAX       : '  , oFont12,, PRETO )
	oPrint:Say(nLinha+=15 ,  20, 'CNPJ      : '  , oFont12,, PRETO )
	oPrint:Say(nLinha     , 270, 'I.E.        : '  , oFont12,, PRETO )
    
    //? CABEÇALHO PRODUTO
    cArqLog += FWTimeStamp(2) + '  Criando Cabeçalho do produto '+ CRLF
	oPrint:Box(nLinha+=20,  15, 302,580, '-8')
	oPrint:Say(nLinha+= 10, 20, 'Item'                , oFont12,, PRETO )
	oPrint:Say(nLinha     , 60, 'Produto'             , oFont12,, PRETO )
	oPrint:Say(nLinha     ,130, 'Descrição do Produto', oFont12,, PRETO )
	oPrint:Say(nLinha     ,280, 'UM'                  , oFont12,, PRETO )
	oPrint:Say(nLinha     ,310, 'Qtd.'                , oFont12,, PRETO )
	oPrint:Say(nLinha     ,350, 'Prc Unit.'           , oFont12,, PRETO )
	oPrint:Say(nLinha     ,410, 'Prc Total.'          , oFont12,, PRETO )
	oPrint:Say(nLinha     ,470, 'IPI'                 , oFont12,, PRETO )
	oPrint:Say(nLinha     ,500, 'Data Entrega'        , oFont12,, PRETO )
	nLinha += 5
	oPrint:Line(nLinha, 15, nLinha, 580, , '-6')

    cArqLog += FWTimeStamp(2) + '  Criando totalizador'+ CRLF
	oPrint:Box(305,130,330,310, '-8')
	oPrint:Say(315, 132, 'Valor Frete: ', oFont12,, PRETO )
	oPrint:Line(318, 132, 318, 310, , '-6')
	oPrint:Say(327, 132, 'Valor despesa: ', oFont12,, PRETO)
	oPrint:Box(305,350,320,490, '-8')
	oPrint:Say(317, 352, 'Valor Total: ', oFont12,, PRETO)
	
    //? INFORMAÇÕES DE CALCULO
    cArqLog += FWTimeStamp(2) + '  Adicionando informações dos calculos'+ CRLF
	oPrint:Box(690, 15,775,580, '-8')
	nLinha := 710
	oPrint:Say(nLinha    ,230, 'Informações Gerais'  , oFont16,, PRETO )
	oPrint:Say(nLinha+=15, 20, 'Forma de Pagamento:' , oFont12,, PRETO )
	oPrint:Say(nLinha+=15, 20, 'Transportadora:'     , oFont12,, PRETO )
	oPrint:Say(nLinha    ,270, 'Descontos %:'        , oFont12,, PRETO )
	oPrint:Say(nLinha+=15, 20, 'Espécie:'            , oFont12,, PRETO )
	oPrint:Say(nLinha    ,270, 'Tipo Frete:'         , oFont12,, PRETO )
	oPrint:Say(nLinha+=15, 20, 'Volume:'             , oFont12,, PRETO )
	oPrint:Say(nLinha    ,270, 'Vendedor:'           , oFont12,, PRETO )

    oPrint:Box(785, 15,810,580, '-8')
	oPrint:Say(798,20, 'Mensagem: ', oFont16,,PRETO)
Return

Static Function ImpDados(cAlias)
	Local nTotalizador  := 0
	Local nFrete        := (cAlias)->(C5_FRETE)
	Local nDespesa      := (cAlias)->(C5_DESPESA)
    local nCont         := 1

    cArqLog += FWTimeStamp(2) + '  Adicionando dados ao relatorio '+ CRLF

	DbSelectArea(cAlias)
    cArqLog += FWTimeStamp(2) + '  Adicionando dados ao relatorio - Informações Rodape'+ CRLF
	ImpRod(cAlias)
	nLine := 125
    cArqLog += FWTimeStamp(2) + '  Adicionando dados ao relatorio - Dados do cliente'+ CRLF
	oPrint:Say(nLine, 68, (cAlias)->(A1_NOME),          oFont10,, PRETO)
	oPrint:Say(nLine, 310, (cAlias)->(A1_HPAGE),        oFont10,, PRETO)
	oPrint:Say(nLine+=15, 68, (cAlias)->(A1_EMAIL),     oFont10,, PRETO)
	oPrint:Say(nLine    ,310, (cAlias)->(A1_CONTATO),   oFont10,, PRETO)
	oPrint:Say(nLine+=15, 68, (cAlias)->(A1_END) ,      oFont10,, PRETO)
	oPrint:Say(nLine    , 310, (cAlias)->(A1_BAIRRO) ,  oFont10,, PRETO)
	oPrint:Say(nLine+=15, 68, (cAlias)->(A1_MUN) ,      oFont10,, PRETO)
	oPrint:Say(nLine    , 310, (cAlias)->(A1_CEP) ,     oFont10,, PRETO)
	oPrint:Say(nLine+=15, 68, (cAlias)->(A1_TEL) ,      oFont10,, PRETO)
	oPrint:Say(nLine    , 310, (cAlias)->(A1_FAX) ,     oFont10,, PRETO)
	oPrint:Say(nLine+=15, 68, Transform((cAlias)->(A1_CGC), '@R 99.999.999/9999-99') , oFont10,, PRETO)
	oPrint:Say(nLine    , 310, (cAlias)->(A1_INSCR) ,   oFont10,, PRETO)
	nLine+=45
	(cAlias)->(DbGoTop())
	while (cAlias)->(!EOF())
        cArqLog += FWTimeStamp(2) + '  Adicionando dados ao relatorio - Dados do produto ' + cValToChar(nCont) + CRLF
	 	nTotalizador += (cAlias)->(C6_VALOR)
		oPrint:Say(nLine,  24, (cAlias)->(C6_ITEM)   , oFont10,, PRETO)
		oPrint:Say(nLine,  60, (cAlias)->(C6_PRODUTO), oFont10,, PRETO)
		oPrint:Say(nLine, 130, (cAlias)->(C6_DESCRI) , oFont10,, PRETO)
		oPrint:Say(nLine, 280, (cAlias)->(C6_UM), oFont10,, PRETO)
		oPrint:Say(nLine, 310, cValToChar((cAlias)->(C6_QTDVEN)), oFont10,, PRETO)
		oPrint:Say(nLine, 350, 'R$' + STRTRAN(STR((cAlias)->(C6_PRCVEN),9,2), ".", ","), oFont10,, PRETO)
		oPrint:Say(nLine, 410, 'R$' + STRTRAN(STR((cAlias)->(C6_VALOR),9,2), ".", ","), oFont10,, PRETO)
		oPrint:Say(nLine, 470, cValToChar((cAlias)->(C6_IPIDEV)), oFont10,, PRETO)
		oPrint:Say(nLine, 510, Dtoc(Stod((cAlias)->(C6_ENTREG))), oFont10,, PRETO)
		nLine += 15
		nCont++
		(cAlias)->(DbSkip())
	enddo
    cArqLog += FWTimeStamp(2) + '  Adicionando dados ao relatorio - Dados do totalizador ' + CRLF
	oPrint:Say(315, 270, 'R$' + STRTRAN(STR(nFrete,7,2), ".", ","), oFont10,, PRETO)
	oPrint:Say(327, 270, 'R$' + STRTRAN(STR(nDespesa,7,2), ".", ","), oFont10,, PRETO)
	oPrint:Say(317, 450, 'R$' + STRTRAN(STR(nTotalizador,7,2), ".", ","), oFont10,, PRETO)
return

Static Function ImpRod(cAlias)
	Local cDescontos :=  cValToChar((cAlias)->(C5_DESC1)) + ' + ' + cValToChar((cAlias)->(C5_DESC2)) + ' + ' + cValToChar((cAlias)->(C5_DESC3)) + ' + ' + cValToChar((cAlias)->(C5_DESC4))
	nLine := 710
	oPrint:Say(nLine+=15, 120,Alltrim((cAlias)->(E4_CODIGO)) + ' - ' + (cAlias)->(E4_DESCRI), oFont10,, PRETO)
	oPrint:Say(nLine+=15, 93, (cAlias)->(A4_NOME) , oFont10,, PRETO)
	oPrint:Say(nLine,     340, cDescontos, oFont10,, PRETO)
	oPrint:Say(nLine+=15, 70, cValToChar((cAlias)->(C5_ESPECI1)), oFont10,, PRETO)
	oPrint:Say(nLine,     340,(cAlias)->(C5_TPFRETE) , oFont10,, PRETO)
	oPrint:Say(nLine+=15, 60, cValToChar((cAlias)->(C5_VOLUME1)) , oFont10,, PRETO)
	oPrint:Say(nLine,     320,(cAlias)->(A3_NOME) , oFont10,, PRETO)
	oPrint:Say(798,90,(cAlias)->(C5_MENNOTA) , oFont10,, PRETO)
return

Static Function CriaPasta()
    Local cNomePasta := '\Pedidos de Venda\'

    if !ExistDir(cNomePasta)
        cArqLog += FWTimeStamp(2) + '  Criando pasta para armazenamento ' + CRLF
        if MakeDir(cNomePasta) <> 0
            FwAlertError('Houve um erro ao criar a pasta!' ,'Erro!')
        endif
    endif
Return cNomePasta

Static Function CriaLog()
    Local cArquivo := M->C5_NUM + '.txt'
    Local oWriter :=  FwFileWriter():New(cCaminho + cArquivo, .T.)

    if File(cCaminho + cArquivo) //? Verifica se existe o arquivo no local já 
        FwAlertError('O arquivo já existe no repositorio!', 'Atenção')
    else
        if !oWriter:Create() //? Caso não conseguiu criar o arquivo
            FwAlertError('Houve um erro ao gerar o Log!' + CRLF + 'Erro: ' + oWriter:Erro():Messege, 'Erro!' )
        else
            oWriter:Write(cArqLog) //? Escreve o texto
            oWriter:Close()
        ENDIF
    endif
            
Return 
