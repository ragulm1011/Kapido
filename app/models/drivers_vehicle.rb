class DriversVehicle < ApplicationRecord
    #Associations
    belongs_to :driver
    belongs_to :vehicle
end
