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
  end
end
