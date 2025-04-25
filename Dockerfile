# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.2.2
FROM ruby:3.2.2-slim

# Instala as dependências essenciais
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs npm git curl libvips

# Define o diretório de trabalho
WORKDIR /app

# Copia os arquivos de dependência
COPY Gemfile Gemfile.lock ./

# Instala as gems
RUN bundle install

# Copia o resto do código
COPY . .

# Precompila os assets
RUN bundle exec rails assets:precompile RAILS_ENV=production

# Expõe a porta 3000
EXPOSE 3000

# Comando para iniciar a aplicação
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
