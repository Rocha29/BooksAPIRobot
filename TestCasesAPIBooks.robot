*** Settings ***
Documentation      Documentaçāo da API: https://fakerestapi.azurewebsites.net/index.html
Suite Setup        Conectar a minha API
Resource           ResourceAPI.robot
#robot -d ./log TestCasesAPIBooks.robot
*** Test Cases ***
Buscar a listagem de todos os livros (GET em todos os livros)
    Requisitar todos os livros
    Conferir o status code  200
    Conferir o reason       OK
    Conferir se retorna uma lista com "200" livros

Buscar um Livro específico (GET em um livro específico)
    Requisitar o livro "15"
    Conferir se retorna todos os dados corretos do livro 15

Cadastrar um novo livro (POST)
    Cadastrar um novo livro
#Conferir se retorna todos os dados do livro cadastrado
 #   Conferir dados do livro cadastrado

Realizar Alteracao no cadastro do livro
    Alterar cadastro


Realizar a exclusao do livro
    Excluir livro       2323
