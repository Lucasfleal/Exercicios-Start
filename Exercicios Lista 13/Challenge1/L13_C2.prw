#INCLUDE 'Totvs.ch'

User Function L13_C2()
    Local cPastaOrig := '\Pedidos de Venda\'
    Local cPastaDest := CriaPasta()
    Local aArquivos  := Directory(cPastaOrig + '*.pdf', 'D', , , 1)
    Local nI         := 0
    Local nTamanho   := LEN( aArquivos )

    if nTamanho > 0
        for nI := 3 to nTamanho 
            if !CpyS2T(cPastaOrig + aArquivos[nI][1], cPastaDest)
                MSGSTOP( 'Houve um erro ao copiar o arquivo!' + aArquivos[nI, 1])
            endif
        next
        FwAlertSuccess('Arquivo(s) copiado(s) com sucesso!', 'Concluido')
    else
        FwAlertInfo('A pasta não possui nenhum conteudo!', 'Atenção!')
    endif
Return 

Static Function CriaPasta()
    Local cRaiz   := 'C:\'
    Local cNomePasta := 'Vendas Protheus\'
    Local cCaminho := cRaiz + cNomePasta

   if !ExistDir(cCaminho)
        if MakeDir(cCaminho) <> 0
            FwAlertError('Houve um erro ao criar a pasta!' ,'Erro!')
        endif
    endif
Return cCaminho

