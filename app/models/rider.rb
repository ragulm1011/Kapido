class Rider < ApplicationRecord
    has_one :user , as: :userable , dependent: :destroy
    has_one :address , as: :addressable , dependent: :destroy
    has_many :rides
    has_many :booking_requests
    has_many :payments
end
