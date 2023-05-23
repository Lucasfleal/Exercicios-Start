#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'

/*/{Protheus.doc} User Function L14Ex01
  Inclusão de cliente por rotina automática
  @type  Function
  @author Lucas Leal
  @since 22/05/2023
  /*/
User Function L14Ex03()
  Local aVetor := {}
  Local nOper  := 5
  Private lMsErroAuto := .F.
  
  PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' MODULO 'COM'
  
  // Adicionando dados ao Array
  Aadd(aVetor, {'A2_COD', '000003', NIL})
  
  // Executando a rotina automatica  
  MSExecAuto({|x, y| MATA020(x, y)}, aVetor, nOper) 
  
  if lMsErroAuto
    MostraErro()
  endif
Return
