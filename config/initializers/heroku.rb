# Configurações específicas para o Heroku
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ['Authorization']
  end
end

# Configuração do Redis para Action Cable e cache
if ENV["REDIS_URL"].present?
  Rails.application.config.cache_store = :redis_cache_store, { url: ENV["REDIS_URL"] }
  Rails.application.config.action_cable.url = ENV["ACTION_CABLE_URL"] if ENV["ACTION_CABLE_URL"].present?
  Rails.application.config.action_cable.allowed_request_origins = [ENV["APP_URL"]] if ENV["APP_URL"].present?
end 