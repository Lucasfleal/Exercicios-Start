#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'RPTDEF.CH'
#INCLUDE 'FWPRINTSETUP.CH'

#DEFINE PRETO    RGB(000, 000, 000)
#DEFINE VERMELHO RGB(255, 000, 000)

#DEFINE MAX_LINE  770

/*/{Protheus.doc} User Function RelEx1
    Relatorio criado para o exercicio 1 da lista 12.
    @type  Function
    @author user
    @since 17/04/2023
    /*/
User Function RelEx1()
    Local cAlias := GeraAlias()

    if !Empty(cAlias)
	    MontaRel(cAlias)
    else    
        FwAlertError('Nenhum Registro encontrado!', 'Atenção')
    endif
Return

Static Function GeraAlias()
    Local aArea  := GetArea()
	Local cAlias := GetNextAlias()
	Local cQuery := ''

	cQuery += 'SELECT' + CRLF
	cQuery += '	  B1_COD,' + CRLF
	cQuery += '   B1_DESC,' + CRLF
	cQuery += '   B1_UM,' + CRLF
	cQuery += '   B1_PRV1,' + CRLF
	cQuery += '   B1_LOCPAD,' + CRLF
	cQuery += '   B1_MSBLQL' + CRLF
	cQuery += 'FROM' + CRLF
	cQuery += '	 ' + RetSqlName('SB1') + ' SB1' + CRLF
	cQuery += 'WHERE' + CRLF
	cQuery += "D_E_L_E_T_ = ' '" + CRLF
	cQuery += 'ORDER BY B1_COD'

	TCQUERY cQuery ALIAS (cAlias) NEW

    (cAlias)->(DbGoTop())

    if (cAlias)->(EOF())
       cAlias := '' 
    endif
    
    RestArea(aArea)
Return cAlias

Static Function MontaRel(cAlias)
    Local cCamPDF := 'C:\Users\Lucas Leal\Desktop\PDFs\'
    Local cArqPDF := 'CadProd.pdf'
    Private nLinha   := 105
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
    Cabecalho(cAlias)
    ImpDados(cAlias)
    oPrint:endPage()
    oPrint:Preview()
Return 

Static Function Cabecalho(cAlias)
    Local cLogo := ('D:\TOTVS12\Protheus\protheus_data\system\LGRL' + SM0->M0_CODIGO + '.png')
    
    Processa({|| }, 'Aguarde...', 'Imprimindo Cabeçalho...', .F.)

    //? Criando caixa que vai estar o cabeçalho da pagina
    oPrint:Box(15, 15, 85, 580, '-8')
    oPrint:Line(50, 100, 50, 580, /*Cor*/, '-6')
    oPrint:SayBitMap(20, 20, cLogo, 70, 65)
    oPrint:Line(15, 100, 85, 100)

    oPrint:Say(35, 110, 'Empresa / Filial: ' + AllTrim(SM0->M0_NOME) + ' / ' + AllTrim(SM0->M0_FILIAL), oFont14,, PRETO)
    oPrint:Say(70, 280, 'Cadastro de Produtos', oFont16,, PRETO)
    
    //? Cabeçalho da tabela
    oPrint:Say(nLinha, 20,  'CÓDIGO',           oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 80,  'DESCRIÇÃO',        oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 340, 'UNI. MEDIDA',      oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 425, 'PREÇO DE VENDA',   oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 530, 'ARMAZÉM',         oFont12, /*Width*/, PRETO)
    
    nLinha += 5

    //? SEPARAÇÃO CABEÇALHO E PRODUTOS
    oPrint:Line(nLinha, 015, nLinha, 580,, '-6')

    nLinha += 20 
Return

Static Function ImpDados(cAlias)
    Local cString  := ''
    Local cPRV1     := ''
    Private nCor   := 0
    Private nQtdPagina   := 1
    
    DbSelectArea(cAlias)

    (cAlias)->(DbGoTop())

    while (cAlias)->(!EOF())
        VeriQuebPg(MAX_LINE)

        //? Caso bloqueado o item fica vermelho
        if AllTrim((cAlias)->((B1_MSBLQL))) == '1'
            nCor := VERMELHO
        else
            nCor := PRETO
        endif

        //? Caso não tenha valor descrito fica como R$ 0,00
        cPRV1 := AllTrim((cAlias)->B1_PRV1)
        if cPRV1 == ''
            cPRV1 := '0.00'
        endif

        //? Imprimindo CÓDIGO
        oPrint:Say(nLinha, 020, AllTrim((cAlias)->(B1_COD)),    oFont10,, nCor)

        //? Vericando se algum dado precisa quebrar a linha
        cString  := AllTrim((cAlias)->(B1_DESC))
        VeriQuebLn(cString, 200, 80)

        //? Imprimindo Dados
        oPrint:Say(nLinha, 355, AllTrim((cAlias)->(B1_UM)),     oFont10,, nCor)
        oPrint:Say(nLinha, 450, 'R$ ' + cPRV1,                  oFont10,, nCor)
        oPrint:Say(nLinha, 545, AllTrim((cAlias)->(B1_LOCPAD)), oFont10,, nCor)
        
        nLinha += 30        
        (cALias)->(DbSkip())
    enddo

    (cAlias)->(DbCloseArea())
Return

Static Function VeriQuebPg(nMax)
    if nLinha > nMax
        oPrint:EndPage()
        oPrint:StartPage()

        nQtdPagina++
        nLinha := 105
        
        Cabecalho()
    endif
    Processa({||}, 'Aguarde...', 'Imprimindo Dados da pagina ' + AllTrim(CVALTOCHAR(nQtdPagina)) + '...', .F.)
Return

Static Function VeriQuebLn(cString, nLineTam, nCol)
    Local cLinha   := ''
    Local lTemQbra := .F.
    Local nQtdLine := MLCount(cString, nLineTam, /*Tab. Size*/, .F.) 
    Local nI       := 1

    if nQtdLine > 1
        lTemQbra := .T.
        for nI := 1 to nQtdLine
            cLinha := MemoLine(cString, nLineTam, nI) 
            oPrint:Say(nLinha, nCol, cLinha, oFont10,, nCor)
            nLinha += 10
        next
    else
        oPrint:Say(nLinha, nCol, cString, oFont10,, nCor)
    endif

    if lTemQbra
        nLinha -= nQtdLine * 10 
    endif
Return
