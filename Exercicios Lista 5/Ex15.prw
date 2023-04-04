#INCLUDE 'TOTVS.CH'

User Function L05Ex15(paam_name)
    Local aA := {}, cMsg := ''

    u_PopulaArray('R',@aA, 12, 1, 50)

    AcertaArray(@aA)

    u_ImprimeArrayLinha(@aA, @cMsg)
    
    FwAlertInfo(cMsg, "Ordem Crescente")
    
Return 

static function AcertaArray(aArray)
    Local nI, nCont ,nMaior := 0, nTempI

    for nCont := LEN( aArray ) to 1 step -1
        for nI := nCont to 1 step -1
            if nMaior < aArray[nI]
                nMaior := aArray[nI]
                nTempI := nI
            endif
        next
        aArray[nTempI] := aArray[nCont]
        aArray[nCont] := nMaior 
        nMaior := 0
    next
return 
