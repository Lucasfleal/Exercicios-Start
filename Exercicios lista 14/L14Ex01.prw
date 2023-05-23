#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'

/*/{Protheus.doc} User Function L14Ex01
  Inclusão de cliente por rotina automática
  @type  Function
  @author Lucas Leal
  @since 22/05/2023
  /*/
User Function L14Ex01()
  Local aVetor := {}
  Local nOper  := 3
  Private lMsErroAuto := .F.
  
  PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' MODULO 'COM'
  
  // Adicionando dados ao Array
  Aadd(aVetor, {'A1_FILIAL', xFilial('SA1'), NIL})
  Aadd(aVetor, {'A1_COD', 'CL0035', NIL})
  Aadd(aVetor, {'A1_LOJA', '01', NIL})
  Aadd(aVetor, {'A1_NOME' , 'Pedro Souza', NIL})
  Aadd(aVetor, {'A1_NREDUZ' , 'Pedro Souza Santana', NIL})
  Aadd(aVetor, {'A1_END' , 'Rua Josevaldo ', NIL})
  Aadd(aVetor, {'A1_TIPO' , 'F', NIL})
  Aadd(aVetor, {'A1_EST' , 'SP', NIL})
  Aadd(aVetor, {'A1_MUN' , 'SUMERE', NIL})
  
  // Executando a rotina automatica  
  MSExecAuto({|x, y| MATA030(x, y)}, aVetor, nOper) 
  
  if lMsErroAuto
    MostraErro()
  endif
Return
