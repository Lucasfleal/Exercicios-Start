#INCLUDE 'Totvs.ch'

/*/{Protheus.doc} User Function Exerc2
    Exercicio 2 da lista para cria��o de arquivo de testo
    @type  Function
    @author Lucas Leal
    @since 24/04/2023
    /*/
User Function L13_02()
    Local cRaiz := GetTempPath() + 'Lista 13 - Ex1\' 
    Local cArquivo := 'Arquivo_Texto.txt'
    Local cCaminho := cRaiz + cArquivo
    Local oWriter :=  FwFileWriter():New(cRaiz + cArquivo, .T.)

    if File(cCaminho) //? Verifica se existe o arquivo no local j� 
        FwAlertError('O arquivo j� existe no repositorio!', 'Aten��o')
    else
        if !oWriter:Create() //? Caso n�o conseguiu criar o arquivo
            FwAlertError('Houve um erro ao gerar o arquivo!' + CRLF + 'Erro: ' + oWriter:Erro():Messege, 'Erro!' )
        else
            oWriter:Write('Ol�' + CRLF + 'Esta � uma cria��o de texto para a lista de exercicio') //? Escreve o texto
            oWriter:Close()

            if MSGYESNO( 'Arquivo gerado com sucesso (' + cCaminho+ ')!', 'Deseja abrir o arquivo ?' ) //? Pergunta se quer abrir o arquivo
            ShellExecute('OPEN', cArquivo, '', cRaiz, 1)
            endif
        ENDIF

    endif
Return 
