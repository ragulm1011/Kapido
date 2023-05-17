class Location < ApplicationRecord

    #Validations
    validates :location_name , :landmark , :city , :pincode , presence: true
    validates :pincode , length: {is: 6} , numericality: { only_integer: true }
    belongs_to :rider

    
    scope :default_locations , -> { Location.where("rider_id = ?" , 3) }
    scope :riders_locations , -> { Location.where.not("rider_id = ?" , 3) }
end
