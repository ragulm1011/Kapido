FactoryBot.define do
  factory :bill do
    bill_date { "2023-05-24" }
    bill_amount { 100 }
    
    ride
    payment
  end
end
