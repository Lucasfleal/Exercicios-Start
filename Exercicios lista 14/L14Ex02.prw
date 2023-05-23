#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'

/*/{Protheus.doc} User Function L14Ex01
  Inclusão de cliente por rotina automática
  @type  Function
  @author Lucas Leal
  @since 22/05/2023
  /*/
User Function L14Ex02()
  Local aVetor := {}
  Local nOper  := 4
  Private lMsErroAuto := .F.
  
  PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' MODULO 'COM'
  
  // Adicionando dados ao Array
  Aadd(aVetor, {'A1_COD', 'CL0035', NIL})
  Aadd(aVetor, {'A1_END' , 'Rua Mauricio Souza', NIL})
  Aadd(aVetor, {'A1_TEL' , '987123782', NIL})
  
  // Executando a rotina automatica  
  MSExecAuto({|x, y| MATA030(x, y)}, aVetor, nOper) 
  
  if lMsErroAuto
    MostraErro()
  endif
Return
