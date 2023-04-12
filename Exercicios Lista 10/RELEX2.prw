#INCLUDE 'TOTVS.CH'
#INCLUDE 'REPORT.CH'

/*/{Protheus.doc} User Function L10EX1
    Relatorio em TReport para o cadastro de produto do exercicio 2 da lista 10
    @type  Function
    @author Lucas Leal
    @since 10/04/2023
    /*/
User Function RELEX2()
    local oReport := GeraRel()

    oReport:PrintDialog()
Return 

Static Function GeraRel()
    local oReport := TReport():NEW('RELEX2', 'Relatório do Fornecedor',, {|oReport| Imprime(oReport)}, 'Relatório para Impressão do Fornecedor', .F.)
    local oSection   := TRSection():NEW(oReport, 'Seção do Fornecedor')

    TRCELL():New(oSection, 'A2_COD'     , 'SA2', 'Código'            )
    TRCELL():New(oSection, 'A2_NOME'    , 'SA2', 'Nome da Empresa'   )
    TRCELL():New(oSection, 'A2_NREDUZ'  , 'SA2', 'Nome Fantasia'     )
    TRCELL():New(oSection, 'A2_MUN'     , 'SA2', 'Municipio'         )
    TRCELL():New(oSection, 'A2_EST'     , 'SA2', 'UF'                )
    TRCELL():New(oSection, 'A2_CEP'     , 'SA2', 'CEP'               )
  
Return oReport

Static Function Imprime(oReport)
    local oSection  := oReport:Section(1)
    DbSelectArea('SA2')

    oReport:StartPage()
    oSection:Init()

    oSection:Cell('A2_COD'):SetValue(M->A2_COD)
    oSection:Cell('A2_NOME'):SetValue(M->A2_NOME)
    oSection:Cell('A2_NREDUZ'):SetValue(M->A2_NREDUZ)
    oSection:Cell('A2_MUN'):SetValue(M->A2_MUN)
    oSection:Cell('A2_EST'):SetValue(M->A2_EST)

    oSection:PrintLine()
    oReport:IncMeter()
    oReport:EndPage()
    SA2->(DbCloseArea())
Return



                