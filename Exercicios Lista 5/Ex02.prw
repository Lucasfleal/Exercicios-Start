#INCLUDE 'TOTVS.CH'

User Function L05Ex02()
    Local aElementos := {}, cMsg := ''

    u_PopulaArray('R',@aElementos, 10, 1, 100)
    u_ImprimeArrayLinha(@aElementos, @cMsg, -1)
    
    FwAlertInfo(cMsg, "Elementos de forma inversa")
Return


