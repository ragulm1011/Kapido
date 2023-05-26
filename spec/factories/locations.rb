FactoryBot.define do
  factory :location do
    location_name { "Peelamedu" }
    landmark { "SEZ IT Park" }
    city { "Coimbatore" }
    pincode { 628502 }
    
    rider
  end
end
