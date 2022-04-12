# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

FactoryBot.create_list(:customer, 10)
FactoryBot.create_list(:tea, 100)
FactoryBot.create_list(:subscription, 3, status: 0, customer: Customer.first)
FactoryBot.create_list(:subscription, 2, status: 1, customer: Customer.first)
FactoryBot.create_list(:subscription, 2, status: 0, customer: Customer.second)
FactoryBot.create_list(:subscription, 2, status: 1, customer: Customer.second)