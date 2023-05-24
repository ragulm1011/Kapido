class Payment < ApplicationRecord
    has_one :bill
    belongs_to :rider
    belongs_to :driver

    #Validations
    validates :mode_of_payment , :amount , :credentials , :payment_date , presence: true
    
end
