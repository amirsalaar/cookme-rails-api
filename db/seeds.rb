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

10.times do 
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

5.times do 
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

puts "#{customers.count} customer created!"
puts "#{cooks.count} cooks created!"
