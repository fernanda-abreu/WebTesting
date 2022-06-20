*** Settings ***
Documentation   Variável do tipo LISTA na seção de variáveis globais que contenha todos os meses do ano
Li

*** Variable ***
@{MESES}       Jan  Fev  Mar  Abr  Mai  Jun  Jul  Ago  Set  Out  Nov  Dez
@{DIAS_DO_MES}        30    28  31   30     31  30  31  31  30  31  30  31        
@{MESES_E_DIAS_1}  JAN=30   FEV=28  MAR=31  ABR=30  MAI=31  JUN=30  JUL=31  AGO=31  SET=30  OUT=31  NOV=30  DEZ=31

&{MESES_E_DIAS}         meses=${MESES}       dias=${DIAS_DO_MES}

&{DIAS_POR_MES_2022}   janeiro=31
...                    fevereiro=28
...                    março=31
...                    abril=30
...                    maio=31
...                    junho=30
...                    julho=31
...                    agosto=31
...                    setembro=30
...                    outubro=31
...                    novembro=30
...                    dezembro=31



*** Test Cases ***
Caso de teste de exemplo 01
    Consulta meses
    Consultar dicionário
    Consulta dicionário 2
    Consulta dicionário 3
    Consulta dicionário 4
    Consulta dicionário 5

*** Keywords ***

Consulta meses
    Log To Console                          ${\n}
    Log To Console                          ${MESES[0]}        
    Log To Console                          ${MESES[1]}
    Log To Console                          ${MESES[2]}
    Log To Console                          ${MESES[3]}
    Log To Console                          ${MESES[4]}
    Log To Console                          ${MESES[5]}
    Log To Console                          ${MESES[6]}
    Log To Console                          ${MESES[7]}
    Log To Console                          ${MESES[8]}
    Log To Console                          ${MESES[9]}
    Log To Console                          ${MESES[10]}
    Log To Console                          ${MESES[11]}



Consultar dicionário
   # Log To Console                      ${MESES_E_DIAS.meses}       ${MESES_E_DIAS.meses}
    Log To Console                          ${\n}
    Log To Console                          Em JANEIRO há ${DIAS_POR_MES_2022.janeiro} dias!
    Log To Console                          Em FEVEREIRO há ${DIAS_POR_MES_2022.fevereiro} dias!
    Log To Console                          Em MARÇO há ${DIAS_POR_MES_2022.março} dias!
    Log To Console                          Em ABRIL há ${DIAS_POR_MES_2022.abril} dias!
    Log To Console                          Em MAIO há ${DIAS_POR_MES_2022.maio} dias!
    Log To Console                          Em JUNHO há ${DIAS_POR_MES_2022.junho} dias!
    Log To Console                          Em JULHO há ${DIAS_POR_MES_2022.julho} dias!
    Log To Console                          Em AGOSTO há ${DIAS_POR_MES_2022.agosto} dias!
    Log To Console                          Em SETEMBRO há ${DIAS_POR_MES_2022.setembro} dias!
    Log To Console                          Em OUTUBRO há ${DIAS_POR_MES_2022.outubro} dias!
    Log To Console                          Em NOVEMBRO há ${DIAS_POR_MES_2022.novembro} dias!
    Log To Console                          Em DEZEMBRO há ${DIAS_POR_MES_2022.dezembro} dias!

Consulta dicionário 2

    Log To Console                          ${\n}
    Log To Console                          ${MESES[0]} = ${DIAS_DO_MES[0]} 
    Log To Console                          ${MESES[1]} = ${DIAS_DO_MES[1]}
    Log To Console                          ${MESES[2]} = ${DIAS_DO_MES[2]}


Consulta dicionário 3
   
    Log To Console    ${\n}
    FOR  ${MESES_E_DIAS}   IN  @{MESES_E_DIAS_1}
        Log To Console    Mês e seus dias: ${MESES_E_DIAS}.
        No Operation
    END 

       
Consulta dicionário 4
    Log To Console    ${\n}
    FOR   ${INDICE}   ${MESES_E_DIAS}   IN ENUMERATE   @{MESES_E_DIAS_1}
        Log To Console    Indice do Mês e seus dias: ${INDICE} --> ${MESES_E_DIAS}.
        No Operation
    END

Consulta dicionário 5
    Log To Console    ${\n}
    FOR   ${INDICE}   ${MESES_E_DIAS}   IN ENUMERATE   @{MESES_E_DIAS_1}
        Log To Console    Mês e seus dias e seu indice: ${MESES_E_DIAS} --> ${INDICE}.
        No Operation
    END