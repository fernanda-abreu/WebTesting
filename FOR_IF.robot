*** Settings ***
Documentation   FOR E IF usando o Robot Framework

# Siga os seguintes passos:

# Declare uma variável do tipo lista com vários números

# Crie uma keyword que percorra essa lista usando o FOR

# Dentro do FOR, faça um bloco IF que imprima no Log a frase "Eu sou o número 5!" e "Eu sou o número 10!", ou seja, só pode imprimir quando o número atual da lista for 5 ou 10.

# Use o ELSE para imprimir no Log a frase "Eu não sou o número 5 e nem o 10!"

*** Variables ***
### Indíce da lista         0  1  2  3  4  5  6  7  8   9  
@{MINHA_LISTA_DE_NUMEROS}   1  2  3  4  5  6  7  8  9  10  

*** Test Case ***
Teste de imprimir apenas alguns números
    Imprimir somente se for 5 e 10
*** Keywords ***
Imprimir somente se for 5 e 10
    Log To Console    ${\n}
    FOR  ${NUMERO}   IN  @{MINHA_LISTA_DE_NUMEROS}
       IF  ${NUMERO} == 5 or ${NUMERO} == 10
          Log To Console    Eu sou o número ${NUMERO}!
      ELSE
          Log To Console    Eu não sou o número 5 e nem o 10!
          Log To Console    ${NUMERO}
      END
    END

       