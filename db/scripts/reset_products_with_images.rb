# Script para resetar produtos e criar novos com imagens
# Execute com: rails runner db/scripts/reset_products_with_images.rb

IMAGES_PATH = Rails.root.join('app/assets/images/gallery')
SAMPLE_IMAGES = Dir[IMAGES_PATH.join('*.jpg')]

if SAMPLE_IMAGES.empty?
  puts 'Nenhuma imagem encontrada em app/assets/images/gallery.'
  exit
end

puts 'Removendo todos os produtos...'
Product.destroy_all

puts 'Criando novos produtos com imagens...'
SAMPLE_IMAGES.each_with_index do |image_path, idx|
  product = Product.create!(
    name: "Produto Exemplo #{idx+1}",
    price: rand(100..300),
    stock: rand(5..20),
    description: "Descrição do produto exemplo #{idx+1}.",
  )
  product.images.attach(
    io: File.open(image_path),
    filename: File.basename(image_path),
    content_type: 'image/jpeg'
  )
  puts "Criado: #{product.name} com imagem #{File.basename(image_path)}"
end

puts 'Processo finalizado!' 