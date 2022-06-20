*** Settings ***

Documentation       Documentação da API:    https://fakerestapi.azurewebsites.net/index.html
Resource            Resource_API.robot
#Suite Setup         Conecta a minha API 
Suite Setup         Create Session      fakeAPI     ${URL} 

***Test Cases***
Buscar a listagem de todos os livros (GET em todos os livros)
    Requisitar todos os livros
    Conferir o status code    200
    Conferir o reason         OK
    Conferir se retorna uma lista com "200" livros
    
Buscar um livro especifico (GET em livro especifico)
    Requisitar o livro "15"
    Conferir o status code    200
    Conferir o reason         OK
    Conferir se retorna todos os dados do livro 15

Cadastrar um novo livro (POST)
    Cadastrar um novo livro
    Conferir o status code    200
    Conferir o reason   OK
    Conferir se retorna todos os dados cadastrados do livro "210"

Alterar um livro (PUT)
    Alterar o livro "152"
    Conferir o status code    200
    Conferir o reason   OK
    Conferir se retorna todos os dados alterados do livro "152"

Deletar um livro (DELETE)
    Excluir o livro "200"
    Conferir o status code    200
    Conferir o reason   OK
#   (o response body deve ser vazio)
    Conferir se excluiu o livro "200"

