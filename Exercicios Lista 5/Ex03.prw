#INCLUDE 'TOTVS.CH'

User Function L05Ex03()
    Local aElementos := {}, cMsg := ''

    u_PopulaArray('A',@aElementos, 30, 1)
    u_ImprimeArrayLinha(@aElementos, @cMsg)
    
    FwAlertInfo(cMsg, "30 Numeros na Array")
Return 
