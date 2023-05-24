class Ride < ApplicationRecord
    belongs_to :rider
    belongs_to :driver
    belongs_to :booking_request
    has_one :bill
    has_one :payment , through: :bill

    #Validations
    validates :ride_date , presence: true
end
