class Address < ApplicationRecord
    #Associations
    belongs_to :addressable , polymorphic: true

    #Validations
    validates :door_no , :street , :district ,:city ,  :state , :pincode , presence: true
    validates :pincode , length: {is: 6} , numericality: { only_integer: true }
    validates :district , :state , format: { with: /\A[a-z A-Z]+\z/, message: "Alphabets are only allowed" }
    
end
