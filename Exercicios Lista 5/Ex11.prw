#INCLUDE 'TOTVS.CH'

User Function L05Ex11()
    Local aA := {}, aB := {}
    Local cMsg := '', nI, nTemp := 0

    u_PopulaArray('A',@aA, 10, 1)

    for nI := 1 to len(aA)
        nTemp += aA[nI]
        AADD( aB, nTemp)
    next

    u_ImprimeArrayLinha(@aB, @cMsg)
    
    FwAlertInfo(cMsg, "Somando numeros anteriores")
Return 
