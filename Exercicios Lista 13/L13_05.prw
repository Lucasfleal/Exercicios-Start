#INCLUDE 'Totvs.ch'

/*/{Protheus.doc} User Function L13_05
    Rotina para apagar a pasta Temp
    @type  Function
    @author Lucas Leal
    @since 24/04/2023
    /*/
User Function L13_05()
    Local cPasta := GetTempPath() + 'Lista 13 - Ex1\'
    Local aArquivos := Directory(cPasta + '*.*', 'D', ,, 1)
    Local nI := 0

    if ExistDir(cPasta)
        if MSGYESNO( 'Confirma a exclusão da pasta e seus arquivos ?', 'Atenção!' )
            if LEN(aArquivos) > 0
                for nI := 3 to LEN(aArquivos)
                    if FErase(cPasta + aArquivos[nI][1]) == -1
                        MsgStop('Houve um erro ao apagar o arquivo' + aArquivos[nI][1])
                    endif
                next
            ENDIF

            if DirRemove(cPasta)
                FwAlertSuccess('Pasta apagada com sucesso', 'Concluido')
            else
                FwalertError('Houve um erro ao excluir a pasta!', 'Error')
            endif
        endif
    endif
Return 
