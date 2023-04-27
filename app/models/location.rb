class Location < ApplicationRecord

    #Validations
    validates :location_name , :landmark , :city , :pincode , presence: true
    validates :pincode , length: {is: 6} , numericality: { only_integer: true }

    
end
