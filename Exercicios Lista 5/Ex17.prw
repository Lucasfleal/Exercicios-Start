#INCLUDE 'TOTVS.CH'

User Function L05Ex17()
    Local cTitle := 'Operação com Array'
    Private aArrayOriginal := {}, aClone := {}
    Private nJanAltu := 290
    Private nJanLarg := 300
    Private oBtnConf, oDlg, oGrp

    Define MSDialog oDlg Title cTitle From 000,000 to nJanAltu,nJanLarg PIXEL

    @ 10, 010 BUTTON oBtnConf PROMPT "Popula Array" Size 065, 25 PIXEL Of oDlg Action(ChamarArray())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    @ 10, 075 BUTTON oBtnConf PROMPT "Imprime Array" Size 065, 25 PIXEL Of oDlg Action(ImprimeOriginal())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    @ 35, 010 BUTTON oBtnConf PROMPT "Array Crescente" Size 065, 25 PIXEL Of oDlg Action(OrdenaCrescente())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    @ 35, 075 BUTTON oBtnConf PROMPT "Array Decrescente" Size 065, 25 PIXEL Of oDlg Action(OrdenaDecrescente())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    @ 60, 010 BUTTON oBtnConf PROMPT "Buscar Valor" Size 065, 25 PIXEL Of oDlg Action(FindValor())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    @ 60, 075 BUTTON oBtnConf PROMPT "Somar" Size 065, 25 PIXEL Of oDlg Action(SomaValor())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    @ 85, 010 BUTTON oBtnConf PROMPT "Média" Size 065, 25 PIXEL Of oDlg Action(MediaArray())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    @ 85, 075 BUTTON oBtnConf PROMPT "Maior e Menor" Size 065, 25 PIXEL Of oDlg Action(MaiorMenor())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    @ 110, 010 BUTTON oBtnConf PROMPT "Embaralhar" Size 065, 25 PIXEL Of oDlg Action(EmbaralhaArray())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    @ 110, 075 BUTTON oBtnConf PROMPT "Números Repetidos" Size 065, 25 PIXEL Of oDlg Action(ContaRepeticao())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    ACTIVATE MSDialog oDlg CENTERED    
Return

Static Function ChamarArray()
    Local cTitle := "Selecione a forma de preencher"
    Private oDlgChama, oBtnConf

    aArrayOriginal := {}

    Define MSDialog oDlgChama Title cTitle From 000,000 to 140,300 PIXEL

    @ 10, 010 BUTTON oBtnConf PROMPT "Automatico" Size 065, 25 PIXEL Of oDlgChama Action(,u_PopulaArray("R", @aArrayOriginal, 8, 1, 20), oDlgChama:End())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    @ 10, 075 BUTTON oBtnConf PROMPT "Sequencial (1-8)" Size 065, 25 PIXEL Of oDlgChama Action(u_PopulaArray("A",@aArrayOriginal, 8, 1), oDlgChama:End())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    @ 35, 010 BUTTON oBtnConf PROMPT "Manual" Size 130, 25 PIXEL Of oDlgChama Action(u_PopulaArray("M",@aArrayOriginal, 8), oDlgChama:End())
    oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")

    ACTIVATE MSDialog oDlgChama CENTERED
Return 

Static Function ImprimeOriginal()
    Local cMsg := ''
    u_ImprimeArrayLinha(aArrayOriginal, @cMsg,,2)
    FwAlertInfo(cMsg, "Array Original")
Return 

Static Function OrdenaCrescente()
    Local cMsg := ''
    aClone := aClone(aArrayOriginal)

    if len(aClone) < 1
        FwAlertError('Não existem dados salvos nesse array, tente adicionar alguns :)', 'Array Vazio')
    else
        aSort(aClone) 
    
        u_ImprimeArrayLinha(aClone, @cMsg,,2)
        FwAlertInfo(cMsg, "Array Crescente")
    endif
Return 

Static Function OrdenaDecrescente()
    Local cMsg := ''
    aClone := aClone(aArrayOriginal)

    if len(aClone) < 1
        FwAlertError('Não existem dados salvos nesse array, tente adicionar alguns :)', 'Array Vazio')
    else
        aSort(aClone,,,{ |x, y| x > y }) 
    
        u_ImprimeArrayLinha(aClone, @cMsg,,2)
        FwAlertInfo(cMsg, "Array Decrescente")
    endif
Return 

Static Function FindValor()
    Local nTempVal := 0
    Local nPos

    if len(aArrayOriginal) < 1
        FwAlertError('Não existem dados salvos nesse array, tente adicionar alguns :)', 'Array Vazio')
        return
    endif

    nTempVal := val(FwInputBox("Digite o valor a ser buscado: ", ""))
    nPos := aScan(aArrayOriginal, nTempVal)

    if nPos > 0
        FwAlertSuccess("O valor " + CVALTOCHAR(nTempVal) +" foi encontrado na posição: " + CVALTOCHAR( nPos ), 'Valor Encontrado')
    else
        FwAlertError("Valor não encontrado dentro da array", 'Valor não encontrado')
    endif
Return 

Static Function SomaValor()
    Local nTempVal := 0, nI

    for nI := 1 to len(aArrayOriginal)
        nTempVal += aArrayOriginal[nI]
    next

    FwAlertInfo('O somatorio do array é: ' + CValToChar(nTempVal), 'Somatorio')
Return 

Static Function MediaArray()
    Local nTempVal := 0, nI

    for nI := 1 to len(aArrayOriginal)
        nTempVal += aArrayOriginal[nI]
    next

    FwAlertInfo('A media dos valores do array é: ' + alltrim(str(nTempVal/len(aArrayOriginal),,2)), 'Média')
Return 


Static Function MaiorMenor()
    Local nMaior, nMenor, nI, nTempVal

    for nI := 1 to len(aArrayOriginal)
        if nI == 1
            nMaior := nMenor := aArrayOriginal[nI]
        else
            nTempVal := aArrayOriginal[nI]
            if nTempVal > nMaior
                nMaior := nTempVal
            elseif nTempVal < nMenor
                nMenor := nTempVal
            endif
        endif
    next

     FwAlertInfo('O maior valor é: ' + alltrim(str(nMaior)) + CRLF;
                + 'O menor valor é: ' + alltrim(str(nMenor)), 'Maior e menor valor')
Return 

Static Function EmbaralhaArray()
    Local nI, nTempVal, cMsg := ''
    Local aAuxArray := {}
    aClone := {}


    for nI := 1 to 8
        nTempVal := RANDOMIZE( 1, 9 )

        if ASCAN( aAuxArray, nTempVal) .OR. nTempVal == 9
            nI--
        else
            AADD( aAuxArray, nTempVal )
            AADD( aClone, aArrayOriginal[nTempVal])
        endif
    next

    u_ImprimeArrayLinha(aClone, @cMsg,,2)
    FwAlertInfo(cMsg, "Array Embaralhado")
Return 

Static Function ContaRepeticao()
    Local nI, nRepeticao, cMsg := '', nJ
    Local aAuxArray := {}

    for nI := 1 to len(aArrayOriginal)
        if !ASCAN( aAuxArray, aArrayOriginal[nI])
            nRepeticao := 1
            for nJ := nI + 1 to len(aArrayOriginal)
                if aArrayOriginal[nJ] == aArrayOriginal [nI]
                    nRepeticao ++
                endif
            next 
            If nRepeticao > 1
                cMsg += 'O Valor ' + CVALTOCHAR(aArrayOriginal[nI]) + ' aparece ' + CVALTOCHAR(nRepeticao) + ' vezes na array' + CRLF
            endif
        endif
        AADD( aAuxArray, aArrayOriginal [nI] )
    next

    if LEN( aAuxArray ) > 0
        FwAlertInfo(cMsg, 'Números Repetidos')
    else
        FwAlertInfo('Não existem numeros repetidos', 'Números Repetidos')
    endif
Return 
