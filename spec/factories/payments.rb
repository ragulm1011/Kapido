FactoryBot.define do
  factory :payment do
    mode_of_payment { "Gpay" }
    amount { 100 }
    credentials { "8778846924" }
    remarks { "Done for a Ride" }
    payment_date { "2023-05-24" }
    bill_no { 161 }
    
    rider
    driver
  end
end
