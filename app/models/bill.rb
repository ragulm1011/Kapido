class Bill < ApplicationRecord
    #Associations
    belongs_to :ride
    belongs_to :payment

    
end
