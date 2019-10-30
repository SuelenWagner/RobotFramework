*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${URL}              http://automationpractice.com
${BROWSER}          chrome

*** Keywords ***
### Setup e Teardown
Abrir navegador
    Open Browser        about:blank      ${BROWSER}

Fechar navegador
    Close Browser

### Ações
Acessar a página home do site
    Go to               ${URL}
    Title Should Be     My Store

Digitar o nome de produto "${PRODUCT}" no campo de pesquisa
    Input Text      id=search_query_top     ${PRODUCT}

### Conferências
Clicar no botão de pesquisa
    Click Element   name=submit_search

Conferir se o produto "${PRODUCT}" foi listado nos resultados do site
    Wait Until Element Is Visible       css=#center_column > h1
    Title Should Be                     Search - My Store
    Page Should Contain Image           xpath=//*[@id="center_column"]//*[@src='${URL}/img/p/7/7-home_default.jpg']
    Page Should Contain Link            xpath=//*[@id="center_column"]//a[@class="product-name"][contains(text(),"${PRODUCT}")]

Conferir mensagem de erro "${ALERT_MESSAGE}"
    Wait Until Element Is Visible       xpath=//*[@id="center_column"]/p[@class="alert alert-warning"]
    Element Text Should Be              xpath=//*[@id="center_column"]/p[@class="alert alert-warning"]          ${ALERT_MESSAGE}
