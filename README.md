# Blog GraphQL API

Desenvolvido por Eduardo Wanderley

## Sobre o Projeto

Este é um projeto de API GraphQL para um blog, desenvolvido com Ruby on Rails. O sistema inclui:

- Sistema completo de autenticação JWT
- CRUD de posts com categorias e tags
- Sistema de comentários aninhados
- API GraphQL moderna e bem estruturada

## Tecnologias Utilizadas

- Ruby 3.2.2
- Rails 7.1.5
- GraphQL
- Devise + JWT para autenticação
- SQLite3 (desenvolvimento)

## Como Executar

1. Clone o repositório

```bash
git clone https://github.com/eduardowanderleyde/graph-study.git
cd graph-study
```

2. Instale as dependências

```bash
bundle install
```

3. Configure o banco de dados

```bash
rails db:create db:migrate
```

4. Inicie o servidor

```bash
rails server
```

5. Acesse o GraphiQL em `http://localhost:3000/graphiql`

## Exemplos de Queries

### Criar um usuário

```graphql
mutation {
  createUser(input: {
    email: "seu@email.com"
    password: "sua_senha"
    passwordConfirmation: "sua_senha"
  }) {
    user {
      id
      email
    }
    errors
  }
}
```

### Login

```graphql
mutation {
  signInUser(input: {
    email: "seu@email.com"
    password: "sua_senha"
  }) {
    token
    user {
      id
      email
    }
    errors
  }
}
```

## Contato

Eduardo Wanderley - [GitHub](https://github.com/eduardowanderleyde)

## Licença

Este projeto está sob a licença MIT.
