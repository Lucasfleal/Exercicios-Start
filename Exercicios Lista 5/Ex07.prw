#INCLUDE 'TOTVS.CH'

User Function L05Ex07()
    Local aA := {}, aB := {}
    Local cMsg := '', nI

    u_PopulaArray('R',@aA, 15, 1, 30)

    for nI := len(aA) to 1 step -1
        AADD( aB, aA[nI] )
    next

    u_ImprimeArrayLinha(@aB, @cMsg)
    
    FwAlertInfo(cMsg, "Criando Array Invertido")
Return 
