class BookingRequest < ApplicationRecord

    #Associations
    belongs_to :rider
    has_one :ride

    validates :city , :booking_status , :vehicle_type , :vehicle_type , presence: true
    
end
