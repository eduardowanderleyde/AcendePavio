# Acende Pavio

Uma plataforma de e-commerce moderna para venda de roupas e acessórios de carnaval.

## Tecnologias

- Ruby 3.2.2
- Rails 7.1.5
- PostgreSQL
- Bootstrap
- Devise para autenticação
- Kaminari para paginação
- Active Storage para upload de imagens

## Funcionalidades

- Catálogo de produtos com categorias
- Sistema de busca e filtros
- Carrinho de compras
- Autenticação de usuários
- Painel administrativo
- Upload de imagens
- Paginação
- Responsivo

## Configuração do Ambiente

1. Clone o repositório:

```bash
git clone [url-do-repositório]
cd acende_pavio
```

2. Instale as dependências:

```bash
bundle install
```

3. Configure o banco de dados:

```bash
rails db:create db:migrate db:seed
```

4. Inicie o servidor:

```bash
rails server
```

5. Acesse a aplicação em:

```
http://localhost:3000
```

## Estrutura do Banco de Dados

- Users (Devise)
- Products
- Categories
- Orders
- OrderItems
- Tags
- Posts
- Comments

## Contribuição

1. Fork o projeto
2. Crie sua Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a Branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## Licença

Este projeto está sob a licença MIT.
