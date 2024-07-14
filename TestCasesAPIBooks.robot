*** Settings ***
Documentation      Documentaçāo da API: https://fakerestapi.azurewebsites.net/index.html
Suite Setup        Conectar a minha API
Resource           ResourceAPI.robot
#robot -d ./log -i Regressivo TestCasesAPIBooks.robot
*** Test Cases ***
CT01 Buscar a listagem de todos os livros (GET em todos os livros)
    [Tags]        GET        Regressivo 
    Requisitar todos os livros
    Conferir o status code  200
    Conferir o reason       OK
    Conferir se retorna uma lista com "200" livros

CT02 Buscar um Livro específico (GET em um livro específico)
    [Tags]        GET        Regressivo_99
    Requisitar o livro "15"
    Conferir se retorna todos os dados corretos do livro 15

CT03 Cadastrar um novo livro (POST)
    [Tags]        POST        Regressivo
    Cadastrar um novo livro
#Conferir se retorna todos os dados do livro cadastrado
 #   Conferir dados do livro cadastrado

CT04 Realizar Alteracao no cadastro do livro
    [Tags]        PATH        Regressivo
    Alterar cadastro


CT05 Realizar a exclusao do livro
    [Tags]        DELETE        Regressivo
    Excluir livro       2323
