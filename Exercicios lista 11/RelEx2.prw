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
User Function RELEX2()
	MontaRel()
Return

Static Function MontaRel()
    Local cCamPDF := 'C:\Users\Lucas Leal\Desktop\PDFs\'
    Local cArqPDF := 'CadForn.pdf'
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
    Cabecalho()
    ImpDados()
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
    oPrint:Say(70, 280, 'Cadastro do Fornecedor', oFont16,, PRETO)
    
    //? Cabeçalho da tabela
    oPrint:Say(nLinha, 20,  'CÓDIGO',           oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 80,  'Nome da Empresa',  oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 240, 'Nome Fantasia',    oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 425, 'Municipio',        oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 545, 'UF',               oFont12, /*Width*/, PRETO)
    
    nLinha += 5
    //? SEPARAÇÃO CABEÇALHO E PRODUTOS
    oPrint:Line(nLinha, 015, nLinha, 580,, '-6')

    nLinha += 20 
Return

Static Function ImpDados()
    Local cString  := ''
    
    DbSelectArea('SA2')

    oPrint:Say(nLinha, 020, AllTrim((SA2->A2_COD)),       oFont10,, PRETO)

    cString  := AllTrim(SA2->A2_NOME)
    VeriQuebLn(cString, 30, 80)

    cString  := AllTrim(SA2->A2_NREDUZ)
    VeriQuebLn(cString, 30, 240)

    oPrint:Say(nLinha, 425, AllTrim(SA2->A2_MUN), oFont10,, PRETO)
    oPrint:Say(nLinha, 545, AllTrim(SA2->A2_EST), oFont10,, PRETO)

    SA2->(DbCloseArea())
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
            oPrint:Say(nLinha, nCol, cLinha, oFont10,, PRETO)
            nLinha += 10
        next
    else
        oPrint:Say(nLinha, nCol, cString, oFont10,, PRETO)
    endif

    if lTemQbra
        nLinha -= nQtdLine * 10 
    endif
Return
