class BookingRequest < ApplicationRecord
    belongs_to :rider
    has_one :ride
end
