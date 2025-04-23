# Blog GraphQL API

[![Ruby](https://img.shields.io/badge/Ruby-3.2.2-red.svg)](https://www.ruby-lang.org/)
[![Rails](https://img.shields.io/badge/Rails-7.1.5-red.svg)](https://rubyonrails.org/)
[![GraphQL](https://img.shields.io/badge/GraphQL-Latest-pink.svg)](https://graphql.org/)
[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Author](https://img.shields.io/badge/Author-Eduardo%20Wanderley-green.svg)](https://github.com/eduardowanderleyde)

<div align="center">
  <img src="https://raw.githubusercontent.com/github/explore/e65ef46ef3e7bc457c93622f6a89fe8d3fd131d5/topics/graphql/graphql.png" alt="GraphQL" width="100"/>
  <br>
  <strong>Uma API moderna e flexível para blog usando GraphQL e Ruby on Rails</strong>
</div>

## 🚀 Sobre o Projeto

Este é um projeto moderno de API GraphQL para blog, desenvolvido com Ruby on Rails. O sistema oferece uma experiência rica em recursos para gerenciamento de conteúdo.

### ✨ Características

- 🔐 Autenticação JWT segura
- 📝 CRUD completo de posts
- 🏷️ Sistema de categorias e tags
- 💬 Comentários aninhados
- 🎯 API GraphQL otimizada
- 📚 Documentação completa

## 🛠️ Tecnologias Utilizadas

- 💎 Ruby 3.2.2
- 🛤️ Rails 7.1.5
- 📊 GraphQL
- 🔒 Devise + JWT
- 🗄️ SQLite3 (desenvolvimento)

## 🚀 Como Executar

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

## 📚 Exemplos de Uso

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

## 🤝 Contribuindo

Contribuições são sempre bem-vindas! Para contribuir:

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📫 Contato

Eduardo Wanderley - [GitHub](https://github.com/eduardowanderleyde)

## 📝 Licença

Este projeto está sob a licença MIT - veja o arquivo [LICENSE](LICENSE) para mais detalhes.
