# Configurações de segurança
Rails.application.config.action_dispatch.default_headers = {
  'X-Frame-Options' => 'SAMEORIGIN',
  'X-XSS-Protection' => '1; mode=block',
  'X-Content-Type-Options' => 'nosniff',
  'X-Download-Options' => 'noopen',
  'X-Permitted-Cross-Domain-Policies' => 'none',
  'Referrer-Policy' => 'strict-origin-when-cross-origin',
  'Content-Security-Policy' => "default-src 'self' https: data: 'unsafe-inline' 'unsafe-eval'; img-src 'self' https: data:; font-src 'self' https: data:;"
}

# Configuração do Devise
Devise.setup do |config|
  config.secret_key = ENV['DEVISE_SECRET_KEY']
  config.mailer_sender = ENV['DEFAULT_FROM_EMAIL']
  config.pepper = ENV['DEVISE_PEPPER']
  config.stretches = Rails.env.test? ? 1 : 12
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 8..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
end 