# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Criando categorias
categories = [
  'Velas Aromáticas',
  'Velas Decorativas',
  'Velas para Presente',
  'Velas Naturais',
  'Velas Temáticas'
].map do |name|
  Category.find_or_create_by!(name: name)
end

# Limpar produtos existentes
Product.destroy_all

# Diretório com as imagens
image_dir = '/Users/Wander/Downloads/carnaval 2025'

# Lista de arquivos de imagem
image_files = Dir.glob(File.join(image_dir, '*')).select { |f| File.file?(f) }

# Criando produtos com imagens
30.times do |i|
  product = Product.create!(
    name: Faker::Commerce.unique.product_name,
    description: Faker::Lorem.paragraph(sentence_count: 3),
    price: Faker::Commerce.price(range: 20..200.0),
    stock: Faker::Number.between(from: 5, to: 50),
    user: User.first || User.create!(
      email: 'admin@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
  )

  # Associando categorias aleatórias
  product.categories << categories.sample(rand(1..3))

  # Anexando uma imagem se disponível
  if i < image_files.length
    product.image.attach(
      io: File.open(image_files[i]),
      filename: File.basename(image_files[i])
    )
  end
end

puts "Criados #{Category.count} categorias e #{Product.count} produtos!"
