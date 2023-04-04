#INCLUDE 'TOTVS.CH'

User Function L05Ex12()
    Local aA := {}, aB := {}
    Local cMsg := '', nI

    u_PopulaArray('R',@aA, 5, -10, 15)

    for nI := 1 to len(aA)
        AADD( aB, aA[nI] * -1 )
    next

    u_ImprimeArrayLinha(@aB, @cMsg)
    
    FwAlertInfo(cMsg, "Trocando Sinal")
Return 
