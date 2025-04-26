# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Criando categorias principais
categories = [
  { name: 'Tops', description: 'Blusas e tops com design exclusivo' },
  { name: 'Shorts', description: 'Shorts confortáveis e estilosos' },
  { name: 'Vestidos', description: 'Vestidos para todas as ocasiões' },
  { name: 'Saias', description: 'Saias com personalidade' }
].map do |category_data|
  Category.find_or_create_by!(name: category_data[:name]) do |category|
    category.description = category_data[:description]
  end
end

puts "✨ Criando produtos..."

# Diretório com as imagens
image_dir = Rails.root.join('app', 'assets', 'images', 'gallery')

# Lista de arquivos de imagem (apenas as 6 que restaram)
image_files = Dir.glob(File.join(image_dir, '*')).select { |f| File.file?(f) }
image_files = image_files.first(6) # Garante que só use até 6 imagens

# Criando produtos para cada categoria
categories.each_with_index do |category, idx|
  product = Product.create!(
    name: "#{category.name} #{Faker::Commerce.product_name}",
    description: Faker::Lorem.paragraph(sentence_count: 3),
    price: Faker::Commerce.price(range: 89.0..299.0),
    stock: Faker::Number.between(from: 5, to: 20)
  )
  product.categories << category

  # Anexa 1 imagem apenas ao primeiro produto
  if idx == 0 && image_files.any?
    image_file = image_files.sample
    product.images.attach(
      io: File.open(image_file),
      filename: File.basename(image_file)
    )
  end
end

puts "✨ Seed concluído!"
puts "Criadas #{Category.count} categorias"
puts "Criados #{Product.count} produtos"
