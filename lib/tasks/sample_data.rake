namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    100.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@example.com"
      phone = "312-555-2356"
      Landlord.create!(name: name,
                       email: email,
                       phone: phone)
    end
    landlords = Landlord.all(limit: 20)
    10.times do |n|
      address = "1#{n} Main st."
      zip_code = 60623
      description = "A beautiful building"
      landlords.each { |landlord| landlord.buildings.create!(address: address,
                                                             zip_code: zip_code,
                                                             description: description) } 
    end
  end
end
