*** Settings ***
Resource        ../resource/Resource.robot
Test Setup      Abrir navegador
Test Teardown   Fechar navegador

### Setup roda keyword antes da suite ou antes de um teste
### Teardown roda keyword depois da suite ou depois de um teste

*** Test Cases ***
Caso de Teste 01: Pesquisar produto existente
###{Setup}     Abrir navegador firefox      -> Aqui é aplicado um setup diferente do global
    Acessar a página home do site
    Digitar o nome de produto "Blouse" no campo de pesquisa
    Clicar no botão de pesquisa
    Conferir se o produto "Blouse" foi listado nos resultados do site
# ###{Teardown}  Fechar navegador firefox     -> Aqui é aplicado um teardown diferente do global

Caso de teste 02: Pesquisar produto não existente
    Acessar a página home do site
    Digitar o nome de produto "produtoNãoExistente" no campo de pesquisa
    Clicar no botão de pesquisa
    Conferir mensagem de erro "No results were found for your search "produtoNãoExistente""

Caso de teste 03: Listar produtos
    Acessar a página home do site
    Passar o mouse por cima da categoria "Women" no menu principal superior de categorias
    Clicar na sub categoria "Summer Dresses"
    Conferir se a página exibe os produtos da categoria "Summer Dresses"

Caso de teste 04: Adicionar produtos no carrinho
    Acessar a página home do site
    Digitar o nome de produto "t-shirt" no campo de pesquisa
    Clicar no botão de pesquisa
    Clicar no botão "Add to cart" do produto
    Clicar no botão "Proceed to checkout"
    Conferir se a tela do carrinho de compras foi exibida com os dados do produto

Caso de teste 05: Remover produtos
    Acessar a página home do site
    Clicar no ícone carrinho de compras no menu superior direito
#    Clicar no botão de remoção de produtos (delete) no produto do carrinho
    Conferir se a mensagem "Your shopping cart is empty." foi exibida

Caso de teste 06: Adicionar cliente
    Acessar a página home do site
    Clicar no botão superior direito “Sign in”
    Inserir um e-mail válido
#    Clicar no botão "Create na account"
#    Preencher os campos obrigatórios
#    Clicar em "Register" para finalizar o cadastro
#    Conferir se o cadastro foi realizado com sucesso

# *** Keywords ***
