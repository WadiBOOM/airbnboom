require "json"
require "rest-client"
require "faker"
require "nokogiri"
require 'open-uri'

# https://api.unsplash.com/photos/random?&query=flats,home,livingroom,room,kitchen,bathroom&client_id=ENV['UNSPLASH_CLIENT_ID']
# https://api.unsplash.com/photos/random?&query=face&client_id=ENV['UNSPLASH_CLIENT_ID']

### Destroying all objects ####

Booking.destroy_all
Flat.destroy_all
User.destroy_all

### Wadi Account ###

image_file_api = "https://api.unsplash.com/photos/random?&query=face&client_id=#{ENV['UNSPLASH_CLIENT_ID_1']}"
image_file_serialized = open(image_file_api).read
image = JSON.parse(image_file_serialized)
image_file = URI.open(image['urls']['regular'])

wadi = User.new(
  username: "wadiboom",
  firstname: "Wadi",
  lastname: "Boom",
  address: "14 rue crespin du gast, Paris",
  email: "wadi@airbnboom.com",
  password: "123456",
  )
wadi.photo.attach(io: image_file, filename: 'avatar.jpeg', content_type: 'image/jpeg')
wadi.save!
puts "wadi account created"

### Users ###

10.times do |i|
  image_file_api = "https://api.unsplash.com/photos/random?&query=face&client_id=#{ENV['UNSPLASH_CLIENT_ID_1']}"
  image_file_serialized = open(image_file_api).read
  image = JSON.parse(image_file_serialized)
  image_file = URI.open(image['urls']['regular'])
  user = User.new(
    firstname: Faker::Name.unique.first_name ,
    lastname: Faker::Name.unique.last_name ,
    email: "test#{i}@airbnboom.com",
    password: "123456",
    address: Faker::Address.street_address + ", " + Faker::Address.city
  )
  user.photo.attach(io: image_file, filename: "avatar#{i}.jpeg", content_type: 'image/jpeg')
  user.save!
  puts "User #{i} account created"
end


### Flats ###

for i in (1..11) do
  1.times do |j|
    sleep(2)
    url = "https://www.fakeaddressgenerator.com/Random_Address/FR_Paris"
    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)
    info = html_doc.css('body > div.container.index.no-padding > div.row.main > div.col-md-9.col-sm-9.col-xs-12.main-left > div > div.row.detail.no-margin.no-padding > div.row > div:nth-child(10) > div.col-sm-8.col-xs-6.right > strong > input')
    puts "flat #{i} address parsed !"
    flat = Flat.new(
      title: "Flat of #{User.find(i).firstname}",
      description: "Pretend you are lost in a magical forest as you perch on a log or curl up in the swinging chair. Soak in the tub, then fall asleep in a heavenly bedroom with cloud-painted walls and twinkling lights. And when you wake up, the espresso machine awaits.",
      price: rand(30..100),
      address: info.to_s.split("\"").at(5) + ", Paris",
      capacity: rand(1..6),
      user: User.find(i)
    )
    4.times do |k|
      image_file_api = "https://api.unsplash.com/photos/random?&query=flats,home,livingroom,room,kitchen,bathroom&client_id=#{ENV['UNSPLASH_CLIENT_ID_2']}"
      image_file_serialized = open(image_file_api).read
      image = JSON.parse(image_file_serialized)
      image_file = URI.open(image['urls']['regular'])
      puts "flat #{k*i} image parsed !"
      flat.photos.attach(io: image_file, filename: "flat#{k}.jpeg", content_type: 'image/jpeg')
    end
    flat.save!
    puts "flat #{i} created !"
    sleep(1)
  end
end

### Bookings ###
i = 11
j = 1
for k in (1..11) do
  user = User.find(i)
  flat = Flat.find(j)
  booking = Booking.new(
  user: user,
  flat: flat,
  starts_at: DateTime.strptime("01/25/2021 12:00", "%m/%d/%Y %H:%M"),
  ends_at: DateTime.strptime("01/31/2021 12:00", "%m/%d/%Y %H:%M"),
  client_message: "I am young digital nomad from (CN) and I would love your apartment to be my home for 2 weeks. The working space and view towards the mountains is what inspired me to send you a request and hopefully you will accept me. I am an early bird and early bed time person. I like my morning work out and coffee, but after that I am in full business mood till its time for hot beverage and a good book. Please consider me as your future short term tenant…",
  status: "accepted",
  )
  booking.save!
  booking = Booking.new(
  user: user,
  flat: flat,
  starts_at: DateTime.strptime("02/03/2021 12:00", "%m/%d/%Y %H:%M"),
  ends_at: DateTime.strptime("02/11/2021 12:00", "%m/%d/%Y %H:%M"),
  client_message: "I am young digital nomad from (CN) and I would love your apartment to be my home for 2 weeks. The working space and view towards the mountains is what inspired me to send you a request and hopefully you will accept me. I am an early bird and early bed time person. I like my morning work out and coffee, but after that I am in full business mood till its time for hot beverage and a good book. Please consider me as your future short term tenant…",
  status: "accepted",
  )
  booking.save!
  puts "booking #{k} created !"
  j+=1
  i-=1
end
