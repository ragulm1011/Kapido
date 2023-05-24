FactoryBot.define do
  factory :ride do
    ride_date { "2023-05-24" }
    ride_status { "on-ride" }
    
    rider
    driver
    booking_request
  end
end
