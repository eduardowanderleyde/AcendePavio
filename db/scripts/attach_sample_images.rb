# Script para anexar imagens de exemplo aos produtos sem imagens
# Execute com: rails runner db/scripts/attach_sample_images.rb

require 'active_storage/blob'

IMAGES_PATH = Rails.root.join('app/assets/images/gallery')
SAMPLE_IMAGES = Dir[IMAGES_PATH.join('*.jpg')]

if SAMPLE_IMAGES.empty?
  puts 'Nenhuma imagem encontrada em app/assets/images/gallery.'
  exit
end

Product.find_each do |product|
  if product.images.attached?
    puts "Produto ##{product.id} já possui imagem. Pulando."
    next
  end

  image_path = SAMPLE_IMAGES.sample
  puts "Anexando #{File.basename(image_path)} ao produto ##{product.id} - #{product.name}"
  product.images.attach(
    io: File.open(image_path),
    filename: File.basename(image_path),
    content_type: 'image/jpeg'
  )
end

puts 'Processo finalizado!' 