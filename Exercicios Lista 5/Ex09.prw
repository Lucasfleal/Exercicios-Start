#INCLUDE 'TOTVS.CH'

User Function L05Ex09()
    Local aA := {}, aB := {}
    Local cMsg := '', nI

    u_PopulaArray('R',@aA, 8, 1, 15)

    for nI := 1 to len(aA)
        AADD( aB, aA[nI] * 3 )
    next

    u_ImprimeArrayLinha(@aB, @cMsg)
    
    FwAlertInfo(cMsg, "Triplo do Array A")
Return 
