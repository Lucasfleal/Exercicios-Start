#INCLUDE 'TOTVS.CH'

User Function L05Ex10()
    Local aA := {}, aB := {}, aC := {}
    Local cMsg := '', nI

    u_PopulaArray('R',@aA, 10, 1, 50)
    u_PopulaArray('R',@aB, 15, 1, 50)

    for nI := 1 to len(aA)
        AADD( aC, aA[nI])
    next

    for nI := 1 to len(aB)
        AADD( aC, aB[nI])
    next

    u_ImprimeArrayLinha(@aC, @cMsg)
    
    FwAlertInfo(cMsg, "Juntando A e B")
Return 
