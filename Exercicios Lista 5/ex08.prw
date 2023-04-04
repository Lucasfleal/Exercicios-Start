#INCLUDE 'TOTVS.CH'

User Function L05Ex08()
    Local aA := {1,2,3,4,5,6,7,8}
    Local cMsg := '', nI
    Local nTemp1, nTemp2, nCont := 0

    for nI := 1 to (len(aA) / 2)
        nTemp1 := aA[nI]
        nTemp2 := aA[len(aA) - nCont]

        aA[nI] := nTemp2
        aA[len(aA) - nCont] := nTemp1

        nCont++
    next

    u_ImprimeArrayLinha(@aA, @cMsg)
    
    FwAlertInfo(cMsg, "Invertendo com apenas 1 array")
Return 
