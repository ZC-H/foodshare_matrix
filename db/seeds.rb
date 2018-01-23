# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Seed Users
user = {}
user['password'] = 'aaaa'
#user['password_confirmation'] = 'aaaa'

ActiveRecord::Base.transaction do
  20.times do 
    user['name'] = Faker::Name.first_name + " " + Faker::Name.last_name
    user['email'] = Faker::Internet.email
    user['role'] = rand(0..1)
    User.create(user)
  end
end 

#Seed locations
location = {}

ActiveRecord::Base.transaction do
  20.times do 
    location['longitude'] = rand(101.59218549728394..101.7329478263855)
    location['latitude'] = rand(3.0575535085883843..3.207018557474082)
    location['name'] = Faker::App.name
    Location.create(location)
  end
end

# Seed Listings
event = {}
uids = []
User.all.each { |u| uids << u.id }
locids = []
Location.all.each { |u| locids << u.id }

ActiveRecord::Base.transaction do
  40.times do 
    event['date'] = Date.today - 10 + rand(1..30)
		event['name'] = Faker::RockBand.name
    event['description'] = Faker::Hipster.sentence
    event['location_id'] = locids.sample  	
    event['user_id'] = uids.sample
    event['expected'] = rand(1..60)
    event['food_amount'] = rand(1..500)
    Event.create(event)
  end
end