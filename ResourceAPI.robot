*** Settings ***
Documentation    Documentaçāo da API: https://fakerestapi.azurewebsites.net/index.html
Library          RequestsLibrary
Library          Collections

*** Variables ***
${URL_API}    https://fakerestapi.azurewebsites.net/api/v1/
&{BOOK_15}    id=15
...           title=Book 15
...           pageCount=1500
${expected_page_count}  1500

*** Keywords ***
# SETUP E TEARDOWNS
Conectar a minha API
    Create Session    fakeAPI    ${URL_API}

### ACOES
Requisitar todos os livros
    ${RESPOSTA}    GET On Session         fakeAPI    Books
    Log                ${RESPOSTA.text}
    Set Test Variable  ${RESPOSTA}

# Conferencias

Requisitar o livro "${ID_LIVRO}"
    ${RESPOSTA}    GET On Session         fakeAPI    Books/${ID_LIVRO}
    Log            ${RESPOSTA.text}
    Set Test Variable  ${RESPOSTA}

Conferir o status code
    [Arguments]                     ${STATUS_DESEJADO}
    Should Be Equal As Strings      ${RESPOSTA.status_code}     ${STATUS_DESEJADO}

Conferir o reason
    [Arguments]                     ${REASON_DESEJADO}
    Should Be Equal As Strings      ${RESPOSTA.reason}          ${REASON_DESEJADO}

Conferir se retorna uma lista com "${QTD_LIVROS}" livros
    Length Should Be              ${RESPOSTA.json()}  ${QTD_LIVROS}

Conferir se retorna todos os dados corretos do livro 15
    ${body}=  Evaluate  dict(${RESPOSTA.json()})
    ${body_id}=  Convert To Integer  ${body['id']}
    Set To Dictionary  ${body}  id=${body_id}
    Should Be Equal As Numbers    ${body['id']}    ${BOOK_15.id}    Custom error message: IDs não são iguais
    Should Be Equal As Strings    ${body['title']}    ${BOOK_15.title}    Custom error message: Títulos não são iguais
    # Convert To Integer    ${expected_page_count}=    ${BOOK_15.pageCount}
    # Should Be Equal As Numbers    ${body['pageCount']}    ${expected_page_count}    Custom error message: pageCount não é igual
    # Should Not Be Empty           ${body["description"]}
    # Should Not Be Empty           ${body["excerpt"]}
    # Should Not Be Empty           ${body["publishDate"]}
# Conferencia de POST
Conferir dados do livro cadastrado
    Dictionary Should Contain Item      ${RESPOSTA.json()}      id             ${BOOK_NOVO.id}
    Dictionary Should Contain Item      ${RESPOSTA.json()}      title          ${BOOK_NOVO.title}
    Dictionary Should Contain Item      ${RESPOSTA.json()}      pageCount      ${BOOK_NOVO.pageCount}
    Should Not Be Empty                 ${RESPOSTA.json()["description"]}
    Should Not Be Empty                 ${RESPOSTA.json()["excerpt"]}
    Should Not Be Empty                 ${RESPOSTA.json()["publishDate"]}

# Inclusão POST

Cadastrar um novo livro
    ${HEADERS}      Create Dictionary      content-type=application/json
    ${RESPOSTA}     POST Request       fakeAPI    Books
    ...             data={"id":2323,"title": "TesteQA","description": "QATESTE","pageCount": 29,"excerpt": "TesteQA","publishDate": "2021-03-25T00:51:55.749Z"}
    ...             headers=${HEADERS}
    Log            ${RESPOSTA.text}
    Set Test Variable  ${RESPOSTA}

Alterar cadastro
    ${HEADERS}      Create Dictionary      content-type=application/json
    ${RESPOSTA}     PUT Request       fakeAPI    Books
    ...             data={"id":2323,"title": "TesteQA_Alterado","description": "QATESTE","pageCount": 29,"excerpt": "TesteQA","publishDate": "2021-03-25T00:51:55.749Z"}
    ...             headers=${HEADERS}
    Log            ${RESPOSTA.text}
    Set Test Variable  ${RESPOSTA}

Excluir livro
    [Arguments]                     ${ID_LIVRO_DESEJADO}
    ${RESPOSTA}    DELETE On Session         fakeAPI    Books/${ID_LIVRO_DESEJADO}
    Log            ${RESPOSTA.text}
    Set Test Variable  ${RESPOSTA}