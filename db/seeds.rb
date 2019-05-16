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
NUM_OF_COOKS = 5
NUM_OF_CUSTOMERS = 10

admin = User.create(
  first_name: "Jon",
  last_name: "Snow",
  email: "js@winterfell.gov",
  address: {city: "Winterfell"},
  phone_number: "778-778-7777",
  password: PASSWORD,
  verified: true,
  role: 1
)

NUM_OF_CUSTOMERS.times do 
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    address: {
      street_address: Faker::Address.street_address,
      city: Faker::Address.city,
      province: Faker::Address.state_abbr,
      postal_code: Faker::Address.zip_code
    },
    phone_number: Faker::PhoneNumber.cell_phone,
    password: PASSWORD,
    role: 2
  )
end

customers = User.order(created_at: :desc).limit(10).offset(0)

NUM_OF_COOKS.times do 
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    address: {
      street_address: Faker::Address.street_address,
      city: Faker::Address.city,
      province: Faker::Address.state_abbr,
      postal_code: Faker::Address.zip_code
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
    cook: cooks.sample
  )
  f.schedules.create(weekday: rand(0..6), quantity: rand(10..20))
end

puts "#{customers.count} customer created!"
puts "#{cooks.count} cooks created!"
puts "#{Food.all.count} foods created!"
puts "#{Schedule.all.count} schedules created!" 
