#INCLUDE 'TOTVS.CH'

User Function L05Ex14()
    Local aA := {}

    PopulaArray(@aA)
    ImprimeArray(@aA)

Return 

Static Function PopulaArray(aArray)
    Local nI, cTempChar
    
    for nI := 1 to 12
        cTempChar := char(RANDOMIZE( 97, 122 ))

        if ASCAN( aArray, cTempChar)
            nI--
        else
            AADD( aArray, cTempChar )
        endif
    next
Return 

Static Function ImprimeArray(aArray)
    Local nI, cMsg := ''

    for nI := 1 to len(aArray)
        cMsg += CVALTOCHAR(aArray[nI]) + ', '
    next
    
    FwAlertInfo(cMsg, "Populando com ASCII")
Return
