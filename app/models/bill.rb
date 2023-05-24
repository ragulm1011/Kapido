class Bill < ApplicationRecord
    #Associations
    belongs_to :ride
    belongs_to :payment

    #Validations
    validates :bill_date , :bill_amount , presence: true
    validates :bill_amount , numericality: { only_integer: true } 


    scope :bill_amount_less_than_50 , -> { Bill.where("bill_amount <= ?", 50) }
    scope :bill_amount_greater_than_50 , -> { Bill.where("bill_amount > ?" , 50) }

    
end
