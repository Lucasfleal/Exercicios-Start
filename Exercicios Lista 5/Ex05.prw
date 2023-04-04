#INCLUDE 'TOTVS.CH'

User Function L05Ex05()
    Local aA := {}, aB := {}, aC := {}
    Local cMsg := '', nI, nValTemp

    u_PopulaArray('R',@aA, 20, 1, 30)
    u_PopulaArray('R',@aB, 20, 1, 30)

    for nI := 1 to 20
        nValTemp := aA[nI] + aB [nI]
        AADD( aC, nValTemp )
    next

    u_ImprimeArrayLinha(@aC, @cMsg)
    
    FwAlertInfo(cMsg, "Soma de Array")
Return 
