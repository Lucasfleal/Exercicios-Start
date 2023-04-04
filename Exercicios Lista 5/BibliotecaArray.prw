#INCLUDE 'TOTVS.CH'

User Function PopulaArray(cMetodo,aArray, nQtd,nIni,nFim, nStep)
    Local nTempVal := 0, nI

    if !nStep 
        nStep := 1
    endif

    DO CASE
        CASE cMetodo == 'R'
            for nI := 1 to nQtd
                nTempVal := RANDOMIZE( nIni, nFim )
                AADD( aArray, nTempVal )
            next
            FwAlertSuccess("Array foi populado com sucesso", "Array Populado")
        Case cMetodo == 'A'
            For nI := nIni to nQtd step nStep
                AADD( aArray, nI )
            next
            FwAlertSuccess("Array foi populado com sucesso", "Array Populado")
        Case cMetodo == 'M'
            For nI := 1 to nQtd
                nTempVal :=  val(FwInputBox("Digite um valor: ", ''))
                AADD( aArray, nTempVal )
            next
            FwAlertSuccess("Array foi populado com sucesso", "Array Populado")
        OTHERWISE
            Final("ERRO A02", "ERRO A02 - Erro na criação do Array, verifique o metodo utilizado")
    ENDCASE
Return 

User Function ImprimeArrayLinha(aArray, cMsg, nStep, nOpcaoSep)
    Local nI, cSeparador

    if !nStep
        nStep := 1
    endif

    if !nOpcaoSep .OR. nOpcaoSep == 1
        cSeparador := '' + CRLF
    elseif nOpcaoSep == 2
        cSeparador := ', '
    endif

    If nStep > 0    
        for nI := 1 to len(aArray) step nStep
            cMsg += CVALTOCHAR(aArray[nI]) + cSeparador
        next
    elseif nStep < 0
        for nI := len(aArray) to 1  step nStep
            cMsg += CVALTOCHAR(aArray[nI]) + cSeparador
        next
    else
        Final("ERRO A01", "ERRO A01 - Erro na impressão do Array")
    endif
    
Return 
