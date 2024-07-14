*** Settings ***
Documentation       Exemplos da própria Library: https://github.com/bulkan/robotframework-requests/blob/master/tests/testcase.robot
...                 Doc da API do GitHub: https://developer.github.com/v3/
Library             RequestsLibrary
Library             Collections
Resource            ./variables/my_user_and_passwords.robot

*** Variables ***
${GITHUB_HOST}      https://api.github.com
${ISSUES_URI}       /repos/mayribeirofernandes/myudemyrobotframeworkcourse/issues

*** Test Cases ***
Exemplo: Fazendo autenticação básica (Basic Authentication)
    Conectar com autenticação básica na API do GitHub
    Solicitar os dados do meu usuário

Exemplo: Usando parâmetros
    Conectar na API do GitHub sem autenticação
    Pesquisar issues com o state "open" e com o label "bug"

Exemplo: Usando headers
    Conectar com autenticação básica na API do GitHub
    Enviar a reação "+1" para a issue "8"

*** Keywords ***
Conectar com autenticação básica na API do GitHub
    ${AUTH}             Create List           ${MY_GITHUB_USER}      ${MY_GITHUB_PASS}
    Create Session      alias=mygithubAuth    url=${GITHUB_HOST}     auth=${AUTH}     disable_warnings=True

Solicitar os dados do meu usuário
    ${MY_USER_DATA}     Get Request          alias=mygithubAuth   uri=/user
    Log                 Meus dados: ${MY_USER_DATA.json()}
    Confere sucesso na requisição   ${MY_USER_DATA}

Conectar na API do GitHub sem autenticação
    Create Session      alias=mygithub        url=${GITHUB_HOST}     disable_warnings=True

Pesquisar issues com o state "${STATE}" e com o label "${LABEL}"
    &{PARAMS}           Create Dictionary    state=${STATE}       labels=${LABEL}
    ${MY_ISSUES}        Get Request          alias=mygithub       uri=${ISSUES_URI}    params=${PARAMS}
    Log                 Lista de Issues: ${MY_ISSUES.json()}
    Confere sucesso na requisição   ${MY_ISSUES}

Enviar a reação "${REACTION}" para a issue "${ISSUE_NUMBER}"
    ${HEADERS}          Create Dictionary    Accept=application/vnd.github.squirrel-girl-preview+json
    ${MY_REACTION}      Post Request    alias=mygithubAuth    uri=${ISSUES_URI}/${ISSUE_NUMBER}/reactions
    ...                                 data={"content": "${REACTION}"}     headers=${HEADERS}
    Log                 Meus dados: ${MY_REACTION.json()}
    Confere sucesso na requisição   ${MY_REACTION}

Confere sucesso na requisição
    [Arguments]      ${RESPONSE}
    Should Be True   '${RESPONSE.status_code}'=='200' or '${RESPONSE.status_code}'=='201'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}
