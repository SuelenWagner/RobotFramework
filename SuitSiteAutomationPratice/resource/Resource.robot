*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${URL}              http://automationpractice.com
${BROWSER}          chrome
${FIRSTNAME}        lulu
${LASTNAME}         zinho
${PASSWORD}         luluzinho
${EMAIL}            teste12345
${ADDRESS}          72 Stanley St New Haven
${CITY}             New Haven
${POSTCODE}         06511

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

Passar o mouse por cima da categoria "${CATEGORY}" no menu principal superior de categorias
    Mouse Over          css=#block_top_menu > ul > li:nth-child(1) > a[title="Women"]

Clicar no botão de pesquisa
    Click Element       name=submit_search

Clicar na sub categoria "${SUBCATEGORY}"
    Click Element       css=a[title="Summer Dresses"]

Clicar no botão "${ADDTOCART_BUTTON}" do produto
    Wait Until Page Contains Element     xpath=//*[@id="center_column"]/ul/li/div/div[2]
    Click Element                        xpath=//*[@id="center_column"]//a[@title="Add to cart"]

Clicar no botão "${PROCEEDTOCHECKOUT_BUTTON}"
    Wait Until Element Is Visible        xpath=//*[@id="layer_cart"]/div[1]/div[2]
    Click Element                        xpath=//*[@id="layer_cart"]//a[@title="Proceed to checkout"]

Clicar no ícone carrinho de compras no menu superior direito
    Wait Until Page Contains Element     xpath=//*[@id="header"]//a[@title="View my shopping cart"]
    Click Element                        xpath=//*[@id="header"]//a[@title="View my shopping cart"]

Clicar no botão superior direito “${Signin}”
    Wait Until Element Is Visible        xpath=//*[@id="header"]//a[@class="login"][contains(text(),"${Signin}")]
#    Wait Until Page Contains Element     xpath=//*[@id="header"]//a[@class="login"][contains(text(),"${Signin}")]
    Click Element                        xpath=//*[@id="header"]//a[@class="login"][contains(text(),"${Signin}")]  

Inserir um e-mail válido
    Wait Until Element is Visible        id=email_create
    ${EMAIL}                             Generate Random String
    Input Text                           id=email_create            ${EMAIL}@test.com

Clicar no botão "Create na account"
    Click Element   id=SubmitCreate

Preencher os campos obrigatórios
    Input Text                        id=customer_firstname       ${FIRSTNAME}
    Input Text                        id=customer_lastname        ${LASTNAME}
    Input Text                        id=passwd                   ${PASSWORD}
    Input Text                        id=id=address1              ${ADDRESS}
    Input Text                        id=city                     ${CITY}
    Select From List By Value         id=id_state                 value=7
    Input Text                        id=postcode                 ${POSTCODE}
    Select From List By Value         id=id_country               value=21
    Input Text                        id=phone_mobile             ${MOBILEPHONE}

Clicar em "Register" para finalizar o cadastro
    Click Element       id=submitAccount
### Conferências
Conferir se o produto "${PRODUCT}" foi listado nos resultados do site
    Wait Until Element Is Visible       css=#center_column > h1
    Title Should Be                     Search - My Store
    Page Should Contain Image           xpath=//*[@id="center_column"]//*[@src='${URL}/img/p/7/7-home_default.jpg']
    Page Should Contain Link            xpath=//*[@id="center_column"]//a[@class="product-name"][contains(text(),"${PRODUCT}")]

Conferir mensagem de erro "${ALERT_MESSAGE}"
    Wait Until Element Is Visible       xpath=//*[@id="center_column"]/p[@class="alert alert-warning"]
    Element Text Should Be              xpath=//*[@id="center_column"]/p[@class="alert alert-warning"]    ${ALERT_MESSAGE}

Conferir se a página exibe os produtos da categoria "${SUBCATEGORY}"
    Wait Until Element Is Visible       xpath=//*[@id="center_column"]//span[@class="cat-name"]
    Title Should Be                     Summer Dresses - My Store 
    Page Should Contain Element         xpath=//*[@id="center_column"]//span[@class="cat-name"]

Conferir se a tela do carrinho de compras foi exibida com os dados do produto
    Wait Until Element Is Visible       xpath=//*[@id="cart_title"]
    Title Should Be                     Order - My Store
    Page Should Contain Element         xpath=//*[@id="columns"]//span[@class="navigation_page"]
    Page Should Contain Element         id=total_product
    Page Should Contain Element         id=total_price_container

Conferir se a mensagem "${ALERT_MESSAGE}" foi exibida
    Wait Until Element Is Visible       xpath=//p[@class="alert alert-warning"]
    Element Text Should Be              xpath=//p[@class="alert alert-warning"]    ${ALERT_MESSAGE}     
