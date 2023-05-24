class Rider < ApplicationRecord


    has_one_attached :aadhar_card_image , dependent: :destroy
    #Associations 
    has_one :user , as: :userable , dependent: :destroy
    
    has_many :rides
    has_many :booking_requests
    has_many :payments
    has_many :locations

    #Valiations
    validates :gender , :aadhar_no , presence: true
    validates :aadhar_no , length: { is: 12 } , numericality: { only_integer: true }


    scope :made_rides , -> { joins(:rides).group('riders.id').having('count(rider_id) > 0') }
    scope :does_not_made_rides , -> { where.not(id: Ride.select('rider_id').distinct) }
    
end
