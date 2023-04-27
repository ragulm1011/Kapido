class Driver < ApplicationRecord
   
    #Associations

    has_one :user , as: :userable , dependent: :destroy
    has_one :address , as: :addressable, dependent: :destroy
    has_and_belongs_to_many :vehicles , join_table: :drivers_vehicles
    has_many :payments
    has_many :riders , through: :payments

    #Validations    
    validates :liscense_no , presence: true

end
