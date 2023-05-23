//Bibliotecas
#Include "TOTVS.ch"
 
//Posi��es do Array
Static nPosCodigo   := 1 //Coluna A no Excel
Static nPosDesc     := 2 //Coluna B no Excel
Static nPosTipo     := 3 //Coluna C no Excel
Static nPosUni      := 4 //Coluna D no Excel
Static nPosPrv1     := 5 //Coluna E no Excel
Static nPosStatus   := 6 //Coluna F no Excel

 
/*/{Protheus.doc} User Function L14Ex01
  Inclus�o dos produtos no excel
  @type  Function
  @author Lucas Leal
  @since 22/05/2023
  /*/
 
User Function  L14Ex04()
    Local aArea     := GetArea()
    Private cArqOri := ""
 
    //Seleciona o arquivo
    cArqOri := tFileDialog( "CSV files (*.csv) ", 'Sele��o de Arquivos', , , .F., )

    If !Empty(cArqOri)
        If File(cArqOri) .And. Upper(SubStr(cArqOri, RAt('.', cArqOri) + 1, 3)) == 'CSV'
            Processa({|| fImporta() }, "Importando...")
        Else
            MsgStop("Arquivo e/ou extens�o inv�lida!", "Aten��o")
        EndIf
    EndIf
     
    RestArea(aArea)
Return
 
Static Function fImporta()
    Local aArea      := GetArea()
    Local nTotLinhas := 0
    Local cLinAtu    := ""
    Local nLinhaAtu  := 0
    Local aLinha     := {}
    Local aVetor     := {}
    Local nOper      := 3
    Local oArquivo
    Local aLinhas
    Local cCod, cDesc, cTipo, cUni, cPRV1, cStatus
    Private cDirLog    := GetTempPath() + "x_importacao\"
    Private lMsErroAuto := .F.
    
    oArquivo := FWFileReader():New(cArqOri)
    DbSelectArea('SB1')
    If (oArquivo:Open())
 
        //Se n�o for fim do arquivo
        If ! (oArquivo:EoF())
            aLinhas := oArquivo:GetAllLines()
            nTotLinhas := Len(aLinhas)
            ProcRegua(nTotLinhas)
             
            //Algumas vers�es da Lib n�o aceita o GoTop
            oArquivo:Close()
            oArquivo := FWFileReader():New(cArqOri)
            oArquivo:Open()
 
            While (oArquivo:HasLine())
                aVetor     := {}
                lMsErroAuto := .F.

                nLinhaAtu++
                IncProc("Analisando linha " + cValToChar(nLinhaAtu) + " de " + cValToChar(nTotLinhas) + "...")
                 
                cLinAtu := oArquivo:GetLine()
                aLinha  := StrTokArr(cLinAtu, ";")
                 
                //Se n�o for o cabe�alho
                If !"codigo" $ Lower(cLinAtu) .or. "c�digo" $ Lower(cLinAtu)
 
                    //Zera as variaveis
                    cCod    := aLinha[nPosCodigo]
                    cDesc   := SUBSTR(aLinha[nPosDesc], 1, 30)
                    cTipo   := aLinha[nPosTipo]
                    cUni    := aLinha[nPosUni]
                    cPRV1   := VAL(aLinha[nPosPRV1])
                    cStatus := aLinha[nPosStatus]
    
                    if UPPER(cStatus) == 'A'
                        // Adicionando dados ao Array
                        Aadd(aVetor, {'B1_FILIAL',   xFilial('SB1'), NIL})
                        Aadd(aVetor, {'B1_COD',     cCod,            NIL})
                        Aadd(aVetor, {'B1_DESC',    cDesc,           NIL})
                        Aadd(aVetor, {'B1_TIPO',    cTipo,           NIL})
                        Aadd(aVetor, {'B1_UM',      cUni,            NIL})
                        Aadd(aVetor, {'B1_PRV1',    cPRV1,           NIL})
                        Aadd(aVetor, {'B1_LOCPAD',  '01',            NIL})
                        
                        // Executando a rotina automatica  
                        MSExecAuto({|x, y| MATA010(x, y)}, aVetor, nOper) 

                         if lMsErroAuto
                            MostraErro()
                        endif
                    endif
                EndIf
            EndDo
 
        Else
            MsgStop("Arquivo n�o tem conte�do!", "Aten��o")
        EndIf
 
        //Fecha o arquivo
        oArquivo:Close()
    Else
        MsgStop("Arquivo n�o pode ser aberto!", "Aten��o")
    EndIf
    RestArea(aArea)
Return
