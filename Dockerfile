# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.2.2
FROM ruby:3.2.2-slim

# Instala as dependências essenciais
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs npm git curl libvips postgresql-client && \
    rm -rf /var/lib/apt/lists/*

# Define o diretório de trabalho
WORKDIR /app

# Define variáveis de ambiente para produção
ENV RAILS_ENV=production \
    NODE_ENV=production \
    RAILS_SERVE_STATIC_FILES=true \
    RAILS_LOG_TO_STDOUT=true \
    DB_USERNAME=postgres \
    DB_PASSWORD=wander123 \
    ACENDE_PAVIO_DATABASE_PASSWORD=wander123 \
    DATABASE_URL="postgresql://postgres:wander123@localhost:5432/acende_pavio_production"

# Copia os arquivos de dependência
COPY Gemfile Gemfile.lock ./

# Instala as gems
RUN bundle config set --without 'development test' && \
    bundle install

# Copia o resto do código
COPY . .

# Precompila os assets com uma chave temporária
RUN SECRET_KEY_BASE=dummykey \
    RAILS_MASTER_KEY=444d97da18f15ea794be9778e4bca8ef \
    bundle exec rails assets:precompile

# Expõe a porta 3000
EXPOSE 3000

# Comando para iniciar a aplicação
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
