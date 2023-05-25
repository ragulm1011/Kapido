class Ride < ApplicationRecord
    belongs_to :rider
    belongs_to :driver
    belongs_to :booking_request
    has_one :bill
    has_one :payment , through: :bill

    #Validations
    validates :ride_date , presence: true

    #callbacks
    before_create :set_ride_status
    before_create :set_booking_status_as_booked

    
    def set_ride_status
        self.ride_status = "on-ride"
    end

    
    def set_booking_status_as_booked
        # booking = BookingRequest.find_by(id: self.booking_request_id)
        # p booking
        # booking.booking_status = "booked"
        # booking.save
        # p booking
        self.booking_request.update(booking_status: "booked")
    end

end
