FactoryGirl.define do
  factory :landlord do
    sequence(:name)  { |n| "Landlord #{n}" }
    sequence(:email) { |n| "landlord_#{n}@example.com" }
    phone "312-555-3897"
  end

  factory :building do
    sequence(:address)  { |n| "1#{n} main street" }
    zip_code 60402
    description "beautiful building on the nice part of town."
    landlord
  end

  factory :tenant do
    sequence(:name)  { |n| "Tenant #{n}" }
    sequence(:email) { |n| "tenant_#{n}@example.com" }
    phone "312-555-3897"
    building
  end  
end  
