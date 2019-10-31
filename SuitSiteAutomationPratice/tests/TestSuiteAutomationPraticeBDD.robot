*** Settings ***
Resource        ../resource/Resource.robot
Test Setup      Abrir navegador
Test Teardown   Fechar navegador

*** Variables ***
${URL}          http://automationpractice.com
${BROWSER}      chrome

*** Test Cases ***
Cenário 01: Pesquisar produto existente
    Dado que estou na página home do site
    Quando eu pesquisar pelo produto "Blouse"
    Então o produto "Blouse" deve ser listado na página de resultado da busca

Cenário 02: Pesquisar produto não existente
    Dado que estou na página home do site
    Quando eu pesquisar pelo produto "produtoNãoExistente"
    Então a página deve exibir a mensagem "No results were found for your search "produtoNãoExistente""

*** Keywords ***
Dado que estou na página home do site
    Acessar a página home do site

Quando eu pesquisar pelo produto "${PRODUCT}"
    Digitar o nome de produto "${PRODUCT}" no campo de pesquisa
    Clicar no botão de pesquisa

Então o produto "${PRODUCT}" deve ser listado na página de resultado da busca
    Conferir se o produto "${PRODUCT}" foi listado nos resultados do site

Então a página deve exibir a mensagem "${ALERT_MESSAGE}"
    Conferir mensagem de erro "${ALERT_MESSAGE}"