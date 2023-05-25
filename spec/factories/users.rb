FactoryBot.define do
  factory :user do

    sequence :email do |n|
      "test#{n}@gmail.com"
    end

    
    password { "123456" }
    password_confirmation { "123456" }
    name { "Ragul" }
    age { 20 }
    mobile_no { "9994406107" }
    door_no { "59-A" }
    street { "Gandhi Nagar" }
    city { "Coimbatore" }
    district { "Coimbatore" }
    state { "Tamil Nadu" }
    pincode { 628502 }

    for_rider

    trait :for_rider do
      association :userable, factory: :rider
      role {'Rider'}
    end

    trait :for_driver do
      association :userable, factory: :driver
      role {'Driver'}
    end
  end
end
