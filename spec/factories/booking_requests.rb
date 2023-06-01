FactoryBot.define do
  factory :booking_request do
    city { "Coimbatore" }
    booking_status { "available" }
    vehicle_type { "Sedan-Car" }
    from_location_id { 4 }
    to_location_id { 4 }
    from_location_name { "Rathinam College" }
    to_location_name { "SEZ Park" }
    
    rider
  end
end
