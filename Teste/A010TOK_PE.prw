#INCLUDE 'TOTVS.CH'


User Function ()
    Local cMemoria := M->B1_DESC

     Reclock("SB1",.F.)
     SB1->B1_DESC := 'Cad. Manual - ' + alltrim(cMemoria)
     MSUnlock()
Return Nil
