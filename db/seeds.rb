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
