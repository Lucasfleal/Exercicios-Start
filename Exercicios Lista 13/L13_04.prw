#INCLUDE 'Totvs.ch'

/*/{Protheus.doc} User Function L13_04
    Criação de pasta no RootPath e copia dos arquivos da pasta temporaria da lista de exercicio 13
    @type  Function
    @author Lucas Leal
    @since 24/04/2023
    /*/
User Function L13_04()
    Local cPastaOrig := GetTempPath() + 'Lista 13 - Ex1\'
    Local cPastaDest := '\Lista 13\'
    Local aArquivos  := Directory(cPastaOrig + '*.*', 'D', , , 1)
    Local nI         := 0
    Local nTamanho   := LEN( aArquivos )

    if !ExistDir(cPastaDest) //? Verifica se a pasta de destino existe para poder criar
        if MakeDir(cPastaDest) == 0 //? Cria a pasta
            FwAlertSuccess('Pasta criada com sucesso!','Concluido')
        else
            FwAlertError('Não foi possivel criar a pasta', 'Erro!')
        endif
    else
        FwAlertInfo('Pasta não foi criada pois há mesma já existe!', 'Já existe!')
    endif

    if nTamanho > 0 //? Verifica se existe arquivo para ser copiado
        for nI := 3 to nTamanho //? Copia os arquivos para a nova pasta
            if !CpyT2S(cPastaOrig + aArquivos[nI][1], cPastaDest)
                FwAlertError( 'Houve um erro ao copiar o arquivo!' + aArquivos[nI, 1])
            endif
        next
        FwAlertSuccess('Arquivo(s) copiado(s) com sucesso!', 'Concluido')
    else
        FwAlertInfo('A pasta não possui nenhum conteudo!', 'Atenção!')
    endif

Return 
