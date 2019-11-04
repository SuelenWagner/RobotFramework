*** Settings ***
Library     SeleniumLibrary
Library     String

*** Variables ***
${URL}              http://automationpractice.com
${BROWSER}          chrome
&{CLIENT}           firstName=lulu     lastName=zinho      password=luluzinho    address=72 Stanley St New Haven
...                 city=New Haven     state=7             postalCode=06511      mobilePhone=999999999       
@{SUMMER_DRESSES}   Printed Summer Dress   Printed Summer Dress   Printed Chiffon Dress

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
    Wait Until Element Is Visible   xpath=//*[@id="block_top_menu"]//a[@title="${CATEGORY}"]
    Mouse Over                      xpath=//*[@id="block_top_menu"]//a[@title="${CATEGORY}"]

Clicar no botão de pesquisa
    Click Element       name=submit_search

Clicar na sub-categoria "${SUBCATEGORY}"
    Wait Until Element Is Visible   xpath=//*[@id="block_top_menu"]//a[@title="${SUBCATEGORY}"]
    Click Element                   css=a[title="${SUBCATEGORY}"]

Clicar no botão "Add to cart" do produto
    Wait Until Element Is Visible   xpath=//*[@id="center_column"]//img[@alt="Faded Short Sleeve T-shirts"]
    Click Element                   xpath=//*[@id="center_column"]//img[@alt="Faded Short Sleeve T-shirts"]
    Wait Until Element Is Visible   xpath=//*[@id="add_to_cart"]/button
    Click Button                    xpath=//*[@id="add_to_cart"]/button

Clicar no botão "Proceed to checkout"
    Wait Until Element Is Visible   xpath=//*[@id="layer_cart"]//a[@title="Proceed to checkout"]
    Click Element                   xpath=//*[@id="layer_cart"]//a[@title="Proceed to checkout"]

Adicionar o produto "${PRODUCT}" no carrinho
    Input Text                           id=search_query_top     ${PRODUCT}
    Click Element                        name=submit_search
    Wait Until Page Contains Element     xpath=//*[@id="center_column"]//a[@title="Add to cart"]
    Click Element                        xpath=//*[@id="center_column"]//a[@title="Add to cart"]
    Wait Until Element Is Visible        xpath=//*[@id="layer_cart"]//a[@title="Proceed to checkout"]
    Click Element                        xpath=//*[@id="layer_cart"]//a[@title="Proceed to checkout"]

Deletar produto do carrinho
    Click Element    xpath=//*[@class="cart_quantity_delete"]

Clicar no botão superior direito “Sign in”
    Wait Until Page Contains Element     xpath=//*[@id="header"]//a[@class="login"][contains(text(),"Sign in")]
    Click Element                        xpath=//*[@id="header"]//a[@class="login"][contains(text(),"Sign in")]  


Criar email customizado
    [Arguments]             ${firstName}      ${lastName}
    ${RANDOM_STRING}        Generate Random String
    ${CUSTOM_EMAIL}         Set Variable      ${firstName}${lastName}${RANDOM_STRING}@testerobot.com
    Log                     ${CUSTOM_EMAIL}
    [Return]                ${CUSTOM_EMAIL}


Inserir um e-mail válido
    Wait Until Element is Visible        id=email_create
    ${EMAIL}                             Criar email customizado    ${CLIENT.firstName}     ${CLIENT.lastName}
    Input Text                           id=email_create            ${EMAIL}

Clicar no botão "Create na account"
    Click Element   id=SubmitCreate

Preencher os campos obrigatórios
    Wait Until Page Contains Element  id=customer_firstname 
    Input Text                        id=customer_firstname       lulu                      ${CLIENT.firstName}
    Input Text                        id=customer_lastname        zinho                     ${CLIENT.lastName}
    Input Text                        id=passwd                   luluzinho                 ${CLIENT.password}
    Input Text                        id=address1                 72 Stanley St New Haven   ${CLIENT.address}
    Input Text                        id=city                     New Haven                 ${CLIENT.city}
    Select From List By Value         id=id_state                 7                         ${CLIENT.state}
    Input Text                        id=postcode                 06511                     ${CLIENT.postalCode}
    Input Text                        id=phone_mobile             999999999                 ${CLIENT.mobilePhone}

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
    Element Text Should Be              xpath=//*[@id="center_column"]/p[@class="alert alert-warning"]   ${ALERT_MESSAGE}

Conferir se a página exibe os produtos da sub-categoria "${SUBCATEGORY}"
    Wait Until Element Is Visible    xpath=//*[@id="center_column"]//span[@class="cat-name"]
    Title Should Be                  Summer Dresses - My Store 
    Page Should Contain Element      xpath=//*[@id="center_column"]//span[@class="cat-name"]
    Page Should Contain Element      xpath=//*[@id="center_column"]/ul/li[1]/div/div[2]/h5/a[@title="${SUMMER_DRESSES[0]}"]
    Page Should Contain Element      xpath=//*[@id="center_column"]/ul/li[2]/div/div[2]/h5/a[@title="${SUMMER_DRESSES[1]}"]
    Page Should Contain Element      xpath=//*[@id="center_column"]/ul/li[3]/div/div[2]/h5/a[@title="${SUMMER_DRESSES[2]}"]

Conferir se o produto foi adicionado no carrinho com seus devidos dados e valores
    Wait Until Element Is Visible       xpath=//*[@id="cart_title"][contains(text(),"Shopping-cart summary")]
    Title Should Be                     Order - My Store
    Element Text Should Be              xpath=//*[@class="cart_description"]/*[@class="product-name"]     Faded Short Sleeve T-shirts
    Element Text Should Be              id=total_product              $16.51 
    Element Text Should Be              id=total_price_container      $18.51

Conferir se o carrinho fica vazio
    Wait Until Element Is Visible       xpath=//p[@class="alert alert-warning"]
    Element Text Should Be              xpath=//p[@class="alert alert-warning"]      Your shopping cart is empty.   

Conferir se o cadastro foi realizado com sucesso
    Wait Until Element Is Visible       xpath=//h1[@class="page-heading"]
    Element Text Should Be              xpath=//*[@id="header"]/div[2]//div[1]/a/span       lulu zinho
    Title Should Be                     My account - My Store
    Page Should Contain Element         xpath=//h1[@class="page-heading"][contains(text(),"My account")]
    Page Should Contain Element         xpath=//p[contains(text(),"Welcome to your account. Here you can manage all of your personal information and orders")]  
    Page Should Contain Element         xpath=//a[@title="Information"]
