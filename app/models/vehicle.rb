class Vehicle < ApplicationRecord

    #Associations
    has_and_belongs_to_many :drivers , join_table: :drivers_vehicles

    #Validations
    validates :no_of_seats , length: {is: 2} , numericality: { only_integer: true }
    validates :vehicle_name , :vehicle_type , presence: true
end
