# Configuração do AWS S3 para Active Storage
Rails.application.config.active_storage.service = :amazon

Aws.config.update(
  region: ENV['AWS_REGION'],
  credentials: Aws::Credentials.new(
    ENV['AWS_ACCESS_KEY_ID'],
    ENV['AWS_SECRET_ACCESS_KEY']
  )
)

# Configuração do bucket S3
Rails.application.config.active_storage.service_configurations = {
  amazon: {
    service: 'S3',
    access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region: ENV['AWS_REGION'],
    bucket: ENV['AWS_BUCKET']
  }
} 