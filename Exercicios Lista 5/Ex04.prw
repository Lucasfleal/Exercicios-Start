#INCLUDE 'TOTVS.CH'

User Function L05Ex04()
    Local aElementos := {}, cMsg := ''

    u_PopulaArray('A',@aElementos, 20, 2,,2)
    u_ImprimeArrayLinha(@aElementos, @cMsg)
    
    FwAlertInfo(cMsg, "Numeros Pares")
Return 
