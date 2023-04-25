#INCLUDE 'Totvs.ch'

/*/{Protheus.doc} User Function Exerc1
    Criação de pasta do exercicio 1
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
            FwAlertError('Não foi possivel criar a pasta', 'Erro!')
        endif
    else
        FwAlertInfo('Pasta não foi criada pois há mesma já existe!', 'Já existe!')
    endif
Return 
