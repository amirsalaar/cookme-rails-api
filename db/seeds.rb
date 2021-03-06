# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Schedule.destroy_all
Food.destroy_all
Tagging.destroy_all
Ingredient.destroy_all
Order.destroy_all
OrderItem.destroy_all

PASSWORD = 'supersecret'
NUM_OF_FOODS = 20
NUM_OF_FOODS_ON_SALE = 7
NUM_OF_COOKS = 10
NUM_OF_CUSTOMERS = 5
NUM_OF_INGREDIENTS = 100
SEED_IMAGES_DIR = 'seed_images'

VANCOUVER_ADDRESSES = [
  {street_address: "674 Granville St", postal_code: "V6C 1Z6"},
  {street_address: "300 Cambie St", postal_code: "V6B 2N3"},
  {street_address: "1032 Alberni St", postal_code: "V6E 1A3"},
  {street_address: "780 Richards St", postal_code: "V6B 3A4"},
  {street_address: "568 Beatty St", postal_code: "V6B 2L3"},
  {street_address: "1103 Davie St", postal_code: "V6E 1N2"},
  {street_address: "1518 Robson St", postal_code: "V6G 1C3"},
  {street_address: "556 Beatty St", postal_code: "V6B 2L3"},
  {street_address: "1283 Hamilton St", postal_code: "V6B 6K3"},
  {street_address: "888 Nelson St", postal_code: "V6Z 2H1"},
  {street_address: "2210 Cornwall Ave", postal_code: "V6K 1B5"},
  {street_address: "1690 Robson St", postal_code: "V6G 1C7"},
  {street_address: "2141 Granville St", postal_code: "V6H 3E9"},
  {street_address: "1619 W Broadway", postal_code: "V6J 1W9"},
  {street_address: "85 W 1st Ave", postal_code: "V5Y 3K8"},
  {street_address: "2996 Granville St", postal_code: "V6H 3J7"},
]

admin = User.create(
  first_name: "Jon",
  last_name: "Snow",
  email: "js@winterfell.gov",
  address: {street_address:"1844 W 7th Ave", city: "Vancouver", province:"BC", country: "Canada", postal_code: "V6J 1S8"},
  phone_number: "+17788857036",
  password: PASSWORD,
  verified: true,
  role: 1
)
admin.avatar.attach(io: File.open("#{Rails.root.to_s}/#{SEED_IMAGES_DIR}/avatars/js.png"), filename: "js.png")

customer = User.create(
  first_name: "Daenerys ",
  last_name: "Targaryen",
  email: "dt@winterfell.gov",
  address: {street_address:"1844 W 7th Ave", city: "Vancouver", province:"BC", country: "Canada", postal_code: "V6J 1S8"},
  phone_number: "+17788857036",
  password: PASSWORD,
  role: 2
)
customer.avatar.attach(io: File.open("#{Rails.root.to_s}/#{SEED_IMAGES_DIR}/avatars/dt.jpg"), filename: "dt.jpg")

NUM_OF_CUSTOMERS.times do 
  address = VANCOUVER_ADDRESSES.sample
  u = User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    phone_number: Faker::PhoneNumber.cell_phone,
    password: PASSWORD,
    role: 2
  )
  u.avatar.attach(io: File.open("#{Rails.root.to_s}/#{SEED_IMAGES_DIR}/avatars/#{rand(1..7)}.jpg"), filename: "avatar_#{rand(1..7)}")
end

customers = User.order(created_at: :desc).limit(10).offset(0)

NUM_OF_COOKS.times do 
  address = VANCOUVER_ADDRESSES.sample
  u = User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    address: {
      street_address: address[:street_address],
      city: "Vancouver",
      province: "BC",
      postal_code: address[:postal_code],
      country: "Canada"
    },
    phone_number: Faker::PhoneNumber.cell_phone,
    password: PASSWORD,
    verified: true,
    role: 1
  )
  u.avatar.attach(io: File.open("#{Rails.root.to_s}/#{SEED_IMAGES_DIR}/avatars/#{rand(1..7)}.jpg"), filename: "avatar_#{rand(1..7)}")
end

cooks = User.order(created_at: :desc).limit(5).offset(0)

NUM_OF_INGREDIENTS.times do
  Ingredient.create(name: 
  [ Faker::Food.ingredient, 
    Faker::Food.vegetables,
    Faker::Food.fruits,
    Faker::Food.spice].sample
  )
end

ingredients = Ingredient.all

NUM_OF_FOODS.times do 
  f = Food.create(
    name: Faker::Food.unique.dish,
    description: Faker::Food.description,
    price: rand(6..10) + 0.99,
    cook: cooks.sample,
    ratings: rand(1..5).to_i,
    )
  f.pictures.attach(io: File.open("#{Rails.root.to_s}/#{SEED_IMAGES_DIR}/food_images/#{rand(1..10)}.jpg"), filename: "food_#{rand(1..7)}.jpg")
  f.schedules.create(weekday: rand(0..6), quantity: rand(10..20))
  f.ingredients = ingredients.shuffle.slice(0, rand(5..10))
end

foods = Food.all

NUM_OF_FOODS_ON_SALE.times do 
  f = foods.sample
  f.update( sale_price: f.price * ( 1 - rand(0.1..0.25) ) )
end

puts "#{customers.count} customer created!"
puts "#{cooks.count} cooks created!"
puts "#{Food.all.count} foods created!"
puts "#{Schedule.all.count} schedules created!" 
puts "#{Ingredient.all.count} ingredients created!" 
