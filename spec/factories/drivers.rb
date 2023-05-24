FactoryBot.define do
  factory :driver do
    liscense_no { "CTFPR1048K" }
    driver_rating { 5 }
    standby_city { "Coimbatore" }
    primary_vehicle_id { 1 }
  end
end
