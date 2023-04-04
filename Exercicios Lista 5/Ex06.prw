#INCLUDE 'TOTVS.CH'

User Function L05Ex06()
    Local aA := {}, aB := {}, aC := {}
    Local cMsg := '', nI

    u_PopulaArray('R',@aA, 10, 1, 30)
    u_PopulaArray('R',@aB, 10, 1, 30)

    for nI := 1 to len(aA)
        AADD( aC, aA[nI] )
        AADD( aC, aB[nI] )
    next

    u_ImprimeArrayLinha(@aC, @cMsg)
    
    FwAlertInfo(cMsg, "Juntando Array")
Return 
