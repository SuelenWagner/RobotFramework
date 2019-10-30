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


# *** Keywords ***
