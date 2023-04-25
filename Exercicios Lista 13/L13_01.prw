#INCLUDE 'Totvs.ch'

/*/{Protheus.doc} User Function Exerc1
    Cria��o de pasta do exercicio 1
    @type  Function
    @author Lucas Leal
    @since 24/04/2023
    /*/
User Function L13_01()
    Local cRaiz := GetTempPath()   
    Local cNomePasta := 'Lista 13 - Ex1\'
    Local cCaminho := cRaiz + cNomePasta

     if !ExistDir(cCaminho)
        if MakeDir(cCaminho) == 0
            FwAlertSuccess('Pasta criada com sucesso!','Concluido')
        else
            FwAlertError('N�o foi possivel criar a pasta', 'Erro!')
        endif
    else
        FwAlertInfo('Pasta n�o foi criada pois h� mesma j� existe!', 'J� existe!')
    endif
Return 
