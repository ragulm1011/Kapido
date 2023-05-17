class Bill < ApplicationRecord
    #Associations
    belongs_to :ride
    belongs_to :payment


    scope :bill_amount_less_than_50 , -> { Bill.where("bill_amount <= ?", 50) }
    scope :bill_amount_greater_than_50 , -> { Bill.where("bill_amount > ?" , 50) }

    
end
