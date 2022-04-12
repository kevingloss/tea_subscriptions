# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

FactoryBot.create_list(:customer, 3)
cust_1 = Customer.first
cust_2 = Customer.second 
cust_3 = Customer.third

# Customer 1
sub_1 = FactoryBot.create(:subscription, status: 0, customer: cust_1)
FactoryBot.create_list(:tea_subscription, 2, subscription: sub_1)
sub_2 = FactoryBot.create(:subscription, status: 1, customer: cust_1)
FactoryBot.create_list(:tea_subscription, 2, subscription: sub_2)

# Customer 2
sub_3 = FactoryBot.create(:subscription, status: 0, customer: cust_2)
FactoryBot.create_list(:tea_subscription, 2, subscription: sub_3)
sub_4 = FactoryBot.create(:subscription, status: 1, customer: cust_2)
FactoryBot.create_list(:tea_subscription, 2, subscription: sub_4)

# Customer 3
sub_5 = FactoryBot.create(:subscription, status: 0, customer: cust_3)
FactoryBot.create_list(:tea_subscription, 2, subscription: sub_5)
sub_6 = FactoryBot.create(:subscription, status: 1, customer: cust_3)
FactoryBot.create_list(:tea_subscription, 2, subscription: sub_6)
