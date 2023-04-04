#INCLUDE 'TOTVS.CH'

User Function Funcoes()
    Local cNome := ""

    cNome := PreencheNome()
    ExibeNome(cNome)

Return 

Static Function PreencheNome()
    Local cRetornaNome := ""
    
    cRetornaNome := FwInputBox("Digite aqui seu nome ", cRetornaNome)
    
Return cRetornaNome


Static Function ExibeNome(cMsgNome)

    MSGALERT(cMsgNome, "Esse é o nome")
Return 
