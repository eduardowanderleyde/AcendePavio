# Configuração do Action Mailer
Rails.application.config.action_mailer.delivery_method = :smtp
Rails.application.config.action_mailer.smtp_settings = {
  address: ENV['SMTP_ADDRESS'],
  port: ENV['SMTP_PORT'],
  user_name: ENV['SMTP_USERNAME'],
  password: ENV['SMTP_PASSWORD'],
  authentication: :plain,
  enable_starttls_auto: true
}

# Configuração do host para URLs em emails
Rails.application.config.action_mailer.default_url_options = {
  host: ENV['APP_URL'],
  protocol: 'https'
}

# Configuração do remetente padrão
Rails.application.config.action_mailer.default_options = {
  from: ENV['DEFAULT_FROM_EMAIL']
} 