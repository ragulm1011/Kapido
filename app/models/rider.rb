class Rider < ApplicationRecord

    #Associations 
    has_one :user , as: :userable , dependent: :destroy
    
    has_many :rides
    has_many :booking_requests
    has_many :payments
    has_many :locations

    #Valiations
    validates :gender , :aadhar_no , presence: true
    
end
