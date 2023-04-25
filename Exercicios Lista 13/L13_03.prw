#INCLUDE 'Totvs.ch'

/*/{Protheus.doc} User Function L13_03
    Leitura do arquivo de texto da lista de exercicio
    @type  Function
    @author Lucas Leal
    @since 24/04/2023
    /*/
User Function L13_03()
    Local cPasta    := GetTempPath() + 'Lista 13 - Ex1\'
    Local cArquivo  := 'Arquivo_Texto.txt'
    Local cTxtLinha := ''
    Local aConteudo := {}
    // Local aLinha    := {}
    Local nCont     := 0
    Local oArq      := FwFileReader():New(cPasta + cArquivo)

    if oArq:Open() //? Abre o Arquivo
        if!oArq:EoF() //? Verifica se o arquivo esta vazio
            while oArq:HasLine() //? Enquanto tiver outra linha
                aConteudo := oArq:GetAllLine()
            end
        ENDIF

        for nCont := 1 to Len(aConteudo)
            cTxtLinha += aConteudo[nCont] + CRLF
        Next
        oArq:Close() //? Fecha o arquivo
    ENDIF

    FwAlertInfo(cTxtLinha, 'Conteúdo do Arquivo')
Return 
