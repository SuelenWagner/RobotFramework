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

Cenário 03: Listar produtos
    Dado que estou na página home do site
    Quando eu acessar a categoria "Women" 
    E consultar a sub-categoria "Summer Dresses"
    Então a página deve exibir os produtos da sub-categoria "Summer Dresses"

Cenário 04: Adicionar produtos no carrinho
    Dado que estou na página home do site
    Quando eu pesquisar pelo produto "t-shirt"
    E adicionar no carrinho de compras
    Então a tela do carrinho de compras deve ser exibida mostrando os dados e valores do produto

Caso de teste 05: Remover produtos
    Dado que estou na página home do site
    E existe o produto "t-shirt" adicionado no carrinho de compras
    Quando excluir o produto do carrinho de compras
    Então a página deve exibir a mensagem "Your shopping cart is empty."

Caso de teste 06: Adicionar cliente
    Dado que estou na página home do site
    Quando eu cadastrar um cliente novo
    Então o cadastro deve ser efetuado com sucesso

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

Quando eu acessar a categoria "${CATEGORY}"
    Passar o mouse por cima da categoria "${CATEGORY}" no menu principal superior de categorias
    
E consultar a sub-categoria "${SUBCATEGORY}"
    Clicar na sub-categoria "${SUBCATEGORY}"

Então a página deve exibir os produtos da sub-categoria "${SUBCATEGORY}"
    Conferir se a página exibe os produtos da sub-categoria "${SUBCATEGORY}"

E adicionar no carrinho de compras
    Clicar no botão "Add to cart" do produto
    Clicar no botão "Proceed to checkout"

Então a tela do carrinho de compras deve ser exibida mostrando os dados e valores do produto
    Conferir se o produto foi adicionado no carrinho com seus devidos dados e valores

E existe o produto "${PRODUCT}" adicionado no carrinho de compras
    Adicionar o produto "${PRODUCT}" no carrinho

Quando excluir o produto do carrinho de compras
    Deletar produto do carrinho

Então a página deve exibir a mensagem "Your shopping cart is empty."
    Conferir se o carrinho fica vazio

Quando eu cadastrar um cliente novo
    Clicar no botão superior direito “Sign in”
    Inserir um e-mail válido
    Clicar no botão "Create na account"
    Preencher os campos obrigatórios
    Clicar em "Register" para finalizar o cadastro

Então o cadastro deve ser efetuado com sucesso
    Conferir se o cadastro foi realizado com sucesso