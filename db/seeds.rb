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

PASSWORD = 'supersecret'
NUM_OF_FOODS = 20
NUM_OF_COOKS = 10
NUM_OF_CUSTOMERS = 5
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
  {street_address: "888 Nelson St", postal_code: "V6Z 2H1"}
]

admin = User.create(
  first_name: "Jon",
  last_name: "Snow",
  email: "js@winterfell.gov",
  address: {street_address:"1844 W 7th Ave", city: "Vancouver", province:"BC", country: "Canada", postal_code: "V6J 1S8"},
  phone_number: "778-778-7777",
  password: PASSWORD,
  verified: true,
  role: 1
)
admin.avatar.attach(io: File.open("/home/amirsalar/Dropbox/Projects/CookMe/avatars/js.png"), filename: "js.png")

customer = User.create(
  first_name: "Daenerys ",
  last_name: "Targaryen",
  email: "dt@winterfell.gov",
  address: {street_address:"1844 W 7th Ave", city: "Vancouver", province:"BC", country: "Canada", postal_code: "V6J 1S8"},
  phone_number: "778-778-7777",
  password: PASSWORD,
  role: 2
)
customer.avatar.attach(io: File.open("/home/amirsalar/Dropbox/Projects/CookMe/avatars/dt.jpg"), filename: "dt.jpg")

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
  u.avatar.attach(io: File.open("/home/amirsalar/Dropbox/Projects/CookMe/avatars/#{rand(1..7)}.jpg"), filename: "avatar_#{rand(1..7)}")
end

customers = User.order(created_at: :desc).limit(10).offset(0)

NUM_OF_COOKS.times do 
  address = VANCOUVER_ADDRESSES.sample
  User.create(
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
end

cooks = User.order(created_at: :desc).limit(5).offset(0)

NUM_OF_FOODS.times do 
  f = Food.create(
    name: Faker::Food.unique.dish,
    description: Faker::Food.description,
    price: rand(6..10) + rand,
    cook: cooks.sample,
    )
  f.pictures.attach(io: File.open("/home/amirsalar/Dropbox/Projects/CookMe/food images/#{rand(1..7)}.jpg"), filename: "food_#{rand(1..7)}.jpg")
  f.schedules.create(weekday: rand(0..6), quantity: rand(10..20))
end

puts "#{customers.count} customer created!"
puts "#{cooks.count} cooks created!"
puts "#{Food.all.count} foods created!"
puts "#{Schedule.all.count} schedules created!" 
