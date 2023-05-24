class BookingRequest < ApplicationRecord

    #Associations
    belongs_to :rider
    has_one :ride

    #Validations
    validates :city , :booking_status , :vehicle_type  , presence: true
    validates :from_location_name , :to_location_name , presence: true
    

    scope :available_requests , -> { BookingRequest.where("booking_status = ?" , "available")}
    scope :booked_requests , -> { BookingRequest.where("booking_status = ?" , "booked") }
    
end
