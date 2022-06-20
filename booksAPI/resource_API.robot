*** Settings ***

Documentation       Documentação da API:    https://fakerestapi.azurewebsites.net/index.html
Library             RequestsLibrary
Library             Collections

*** Variable ***
${URL}               https://fakerestapi.azurewebsites.net/api/v1/
&{BOOK_15}           id=15      title=Book 15            pageCount=1500
&{BOOK_210}          id=210     title=Meu Book Novo     description=Meu novo livro conta varias coisas   pageCount=420     excerpt=Meu Novo livro e incrivel.      publishDate=2022-06-10T15:40:01.472Z
&{BOOK_152}          id=152     title=Book 152 alterado  description=Descrição do book 152 alterada      pageCount=300    excerpt=Resumo do book 152 alterado     publishDate=2022-06-10T15:40:01.472Z


***Keywords***

   
###-------------------------------------------------------------------------------------------------------------------------
###ACTION
###-------------------------------------------------------------------------------------------------------------------------

#todos os dados corretos do livro
Requisitar todos os livros
    ${RESPOSTA}                             Get On Session    fakeAPI      Books 
    Log                                     ${RESPOSTA.text}
    Set Test Variable                       ${RESPOSTA}
###-------------------------------------------------------------------------------------------------------------------------

Requisitar o livro "${ID_LIVRO}"
    ${RESPOSTA}                             Get On Session    fakeAPI    Books/${ID_LIVRO}
    Log To Console                          ${RESPOSTA.text}
    Set Test Variable                       ${RESPOSTA}
###-------------------------------------------------------------------------------------------------------------------------

Cadastrar um novo livro    
  
    ${HEADERS}=                             Create Dictionary
    ...                                     Content-Type=application/json


    # ${body}=    Create dictionary   id=201
    # ...                                title=Meu Book Novo
    # ...                                description=Meu novo livro conta varias coisas      
    # ...                                pageCount=420       
    # ...                                excerpt=Meu Novo livro é íncrivel.     
    # ...                                publishDate=2022-06-10T15:40:01.472Z

   ${DATA}=                                 Set Variable                            {"id":210, "title":"Meu Book Novo", "description":"Meu novo livro conta varias coisas", "pageCount":420, "excerpt":"Meu Novo livro e incrivel.", "publishDate":"2022-06-10T15:40:01.472Z"}
    Log To Console   ${DATA}
    ${RESPOSTA}=                            POST On Session   fakeAPI    Books  data=${DATA}     headers=${HEADERS}       ###PQ A NÃO FUNCIONA? Keyword 'RequestsLibrary.Post Request' is deprecated. Please use `POST On Session` instead.
    #...                                      
    # ...                                     headers=${HEADERS}
   
    Log                                     ${RESPOSTA.text}
    Set Test Variable                       ${RESPOSTA}
###-------------------------------------------------------------------------------------------------------------------------

Alterar o livro "${ID_LIVRO}"

    ${HEADERS}=                              Create Dictionary
    ...                                     Content-Type=application/json
    # ${body}=    Create dictionary           id=152
    # ...                                     title=Book 152 alterado
    # ...                                     description=Descrição do book 152 alterada      
    # ...                                     pageCount=300       
    # ...                                     excerpt=Resumo do book 152 alterado     
    # ...                                     publishDate=2022-06-10T15:40:01.472Z

    ${DATA}=                                Set Variable                            {"id":152, "title":"Book 152 alterado", "description":"Descricao do book 152 alterada", "pageCount":300, "excerpt":"Resumo do book 152 alterado", "publishDate":"2022-06-10T15:40:01.472Z"}
    Log To Console   ${DATA}
    ${RESPOSTA}=                            PUT On Session      fakeAPI    Books/${ID_LIVRO}     data=${DATA}     headers=${HEADERS}      
      
    Log                                    ${RESPOSTA.text}
    Set Test Variable                      ${RESPOSTA}

###-------------------------------------------------------------------------------------------------------------------------
Excluir o livro "${ID_LIVRO}"

    ${RESPOSTA}                             Delete On Session    fakeAPI    Books/${ID_LIVRO}
    Log To Console                          ${RESPOSTA.text}
    Set Test Variable                       ${RESPOSTA}


###-------------------------------------------------------------------------------------------------------------------------
###CONFERENCE 
###-------------------------------------------------------------------------------------------------------------------------

Conferir o status code
   [Arguments]                              ${STATUSCODE_DESEJADO}
    Should Be Equal As Strings              ${RESPOSTA.status_code}      ${STATUSCODE_DESEJADO}
###-------------------------------------------------------------------------------------------------------------------------

Conferir o reason   
  [Arguments]                               ${REASON_DESEJADO}
    Should Be Equal As Strings              ${RESPOSTA.reason}           ${REASON_DESEJADO}
###-------------------------------------------------------------------------------------------------------------------------

Conferir se retorna uma lista com "${QTDE_LIVROS}" livros
    Length Should Be                        ${RESPOSTA.json()}           ${QTDE_LIVROS}

###-------------------------------------------------------------------------------------------------------------------------

Conferir se retorna todos os dados do livro 15
    Dictionary Should Contain Item          ${RESPOSTA.json()}          id                ${BOOK_15.id} 
    Dictionary Should Contain Item          ${RESPOSTA.json()}          title             ${BOOK_15.title} 
    Dictionary Should Contain Item          ${RESPOSTA.json()}          pageCount         ${BOOK_15.pageCount} 

    Should Not Be Empty                     ${RESPOSTA.json()["description"]}
    Should Not Be Empty                     ${RESPOSTA.json()["excerpt"]}
    Should Not Be Empty                     ${RESPOSTA.json()["publishDate"]}


###-------------------------------------------------------------------------------------------------------------------------
Conferir se retorna todos os dados cadastrados do livro "${ID_LIVRO}"
    Dictionary Should Contain Item          ${RESPOSTA.json()}          id                ${BOOK_210.id} 
    Dictionary Should Contain Item          ${RESPOSTA.json()}          title             ${BOOK_210.title} 
    Dictionary Should Contain Item          ${RESPOSTA.json()}          pageCount         ${BOOK_210.pageCount} 

    Should Not Be Empty                     ${RESPOSTA.json()["description"]}
    Should Not Be Empty                     ${RESPOSTA.json()["excerpt"]}
    Should Not Be Empty                     ${RESPOSTA.json()["publishDate"]}

    
 ###-------------------------------------------------------------------------------------------------------------------------  
Conferir se retorna todos os dados alterados do livro "${ID_LIVRO}"
    Dictionary Should Contain Item          ${RESPOSTA.json()}          id                ${BOOK_152.id} 
    Dictionary Should Contain Item          ${RESPOSTA.json()}          title             ${BOOK_152.title} 
    Dictionary Should Contain Item          ${RESPOSTA.json()}          pageCount         ${BOOK_152.pageCount} 
  
    Should Not Be Empty                     ${RESPOSTA.json()["description"]}
    Should Not Be Empty                     ${RESPOSTA.json()["excerpt"]}
    Should Not Be Empty                     ${RESPOSTA.json()["publishDate"]}

 ###-------------------------------------------------------------------------------------------------------------------------
Conferir se excluiu o livro "${ID_LIVRO}"
    Should Be Empty                         ${RESPOSTA.content}