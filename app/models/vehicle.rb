class Vehicle < ApplicationRecord

    #Associations
    has_and_belongs_to_many :drivers , join_table: :drivers_vehicles

    #Validations
    
    validates :vehicle_name , :vehicle_type , :no_of_seats ,  presence: true
end
