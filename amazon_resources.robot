*** Settings ***
Library                                     SeleniumLibrary     

*** Variables ***
${BROWSER}                                  chrome
${URL}                                      https://www.amazon.com.br/
${MENU_ELETRONICOS}                         //a[contains(text(),'Eletrônicos')]
${HEADER_ELETRONICOS}                       //h1[normalize-space()='Eletrônicos e Tecnologia']
${TEXTO_HEADER_ELETRONICOS}                 Eletrônicos e Tecnologia
${ADD_TO_CART}                              //span[@class='a-size-medium-plus a-color-base sw-atc-text a-text-bold']
${GO_TO_CART}                               //span[@id='sw-gtc']
${DELETE_TO_CART}                           //span[@class='a-size-small sc-action-delete']//span[@class='a-declarative']
${VALID_TO_CART}                            //h1[normalize-space()='Seu carrinho de compras da Amazon está vazio.']


*** Keywords ***
Abrir o navegador
    Open Browser            browser=${BROWSER} 
    #Set Window Size         3080     2542    False         #Usado para alterar a configuração da tela
    Maximize Browser Window 


###-------------------------------------------------------------------------------------------------------------------------

Fechar o navegador
    Capture Page Screenshot
    Close Browser

###-------------------------------------------------------------------------------------------------------------------------

Acessar a home page do site Amazon.com.br
    Go To       url=${URL} 
    #Execute javascript                      document.body.style.zoom="70%"         #Usado para alterar o zoom da página
    #sleep                                   3s      
    Wait Until Element Is Visible           locator=${MENU_ELETRONICOS}
    #Sleep                                   10s

###-------------------------------------------------------------------------------------------------------------------------

Entrar no menu "Eletrônicos"
    Click Element                           ${MENU_ELETRONICOS}


###-------------------------------------------------------------------------------------------------------------------------

Verificar se aparece a frase "Eletrônicos e Tecnologia"                               
    Wait Until Page Contains                text=${TEXTO_HEADER_ELETRONICOS}
    wait Until Element Is Visible           locator=${HEADER_ELETRONICOS}

###-------------------------------------------------------------------------------------------------------------------------

Verificar se o título da página fica "${TITULO}"    #${TITULO}  = Variável local e pode ser substituida lá no test cases
    Title Should Be                         title=${TITULO}           

###-------------------------------------------------------------------------------------------------------------------------

Verificar se aparece a categoria "${NOME_CATEGORIA}"
    Element Should Be Visible               locator=//a[@aria-label='${NOME_CATEGORIA}']
#//a[@aria-label='Computadores e Informática']//img[@alt='Computadores e Informática']
###-------------------------------------------------------------------------------------------------------------------------

Digitar o nome de produto "${PRODUTO}" no campo de pesquisa
    Input Text      locator=twotabsearchtextbox     text=${PRODUTO}
    #Press Keys    twotabsearchtextbox      ENTER         #Usada para clicar em um campo      
###-------------------------------------------------------------------------------------------------------------------------  

Clicar no botão de pesquisa
    Click Element       locator=nav-search-submit-button

###-------------------------------------------------------------------------------------------------------------------------

Verificar o resultado da pesquisa se está listando o produto "${PRODUTO}"
    Wait Until Element Is Visible       locator=//span[normalize-space()='${PRODUTO}']


#******************************************************GHERKING STEPS*******************************************************

Dado que estou na home page da Amazon.com.br
    Acessar a home page do site Amazon.com.br
    Verificar se o título da página fica "Amazon.com.br | Tudo pra você, de A a Z."

###------------------------------------------------------------------------------------------------------------------------

Quando acessar o menu "Eletrônicos"
     Entrar no menu "Eletrônicos"

###------------------------------------------------------------------------------------------------------------------------

Então o título da página deve ficar "Eletrônicos e Tecnologia | Amazon.com.br"
    Verificar se o título da página fica "Eletrônicos e Tecnologia | Amazon.com.br"

###------------------------------------------------------------------------------------------------------------------------

E o texto "Eletrônicos e Tecnologia" deve ser exibido na página
    Verificar se aparece a frase "Eletrônicos e Tecnologia"


###------------------------------------------------------------------------------------------------------------------------

E a categoria "Computadores e Informática" deve ser exibida na página
    Verificar se aparece a categoria "Computadores e Informática"

###------------------------------------------------------------------------------------------------------------------------

Quando pesquisar pelo produto "Xbox Series S"
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa
    Clicar no botão de pesquisa

###------------------------------------------------------------------------------------------------------------------------

Então o título da página deve ficar "Amazon.com.br : Xbox Series S"
    Verificar se o título da página fica "Amazon.com.br : Xbox Series S"

###------------------------------------------------------------------------------------------------------------------------

E um produto da linha "Xbox Series S" deve ser mostrado na página
     Verificar o resultado da pesquisa se está listando o produto "Console Xbox Series S"

###------------------------------------------------------------------------------------------------------------------------


#*********************************DESAFIO - automatizando mais esses 02 cenários********************************************

Adicionar o produto "${PRODUTO}" no carrinho
    Click Element       //span[normalize-space()='${PRODUTO}']
    Click Element       //span[@id='submit.add-to-cart']

###------------------------------------------------------------------------------------------------------------------------

Verificar se o produto "${PRODUTO}" foi adicionado com sucesso
    wait Until Element Is Visible           ${ADD_TO_CART}                          10

###------------------------------------------------------------------------------------------------------------------------

Remover o produto "${PRODUTO}" do carrinho
    Click Element                           ${GO_TO_CART}
    Sleep                                   2 
    Click Element                           ${DELETE_TO_CART}
    
###------------------------------------------------------------------------------------------------------------------------

Verificar se o carrinho fica vazio
    wait Until Element Is Visible           ${VALID_TO_CART}                        10

###------------------------------------------------------------------------------------------------------------------------

Quando adicionar o produto "${PRODUTO}" no carrinho
    Quando pesquisar pelo produto "Xbox Series S"
    Então o título da página deve ficar "Amazon.com.br : Xbox Series S"
    E um produto da linha "Xbox Series S" deve ser mostrado na página
    Adicionar o produto "${PRODUTO}" no carrinho
    
###------------------------------------------------------------------------------------------------------------------------

Então o produto "${PRODUTO}" deve ser mostrado no carrinho
    Verificar se o produto "${PRODUTO}" foi adicionado com sucesso

###------------------------------------------------------------------------------------------------------------------------

E existe o produto "${PRODUTO}" no carrinho
    Quando adicionar o produto "${PRODUTO}" no carrinho
    Verificar se o produto "Console Xbox Series S" foi adicionado com sucesso

###------------------------------------------------------------------------------------------------------------------------

Quando remover o produto "${PRODUTO}" do carrinho
    Remover o produto "${PRODUTO}" do carrinho

###------------------------------------------------------------------------------------------------------------------------

Então o carrinho deve ficar vazio
    Verificar se o carrinho fica vazio