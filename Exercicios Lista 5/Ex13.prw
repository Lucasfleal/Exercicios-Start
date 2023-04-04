#INCLUDE 'TOTVS.CH'

User Function L05Ex13()
    Local aA := {}
    Local cMsg := ''

    PopulaArray(@aA)

    u_ImprimeArrayLinha(@aA, @cMsg,,2)
    
    FwAlertInfo(cMsg, "Populando com ASCII")
Return 

Static Function PopulaArray(aArray)
    Local nI, nTempVal
    
    for nI := 1 to 50
        nTempVal := RANDOMIZE( 65, 90 )
        AADD( aArray, char(nTempVal) )
    next
Return 
