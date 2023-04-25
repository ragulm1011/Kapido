class Vehicle < ApplicationRecord
    has_and_belongs_to_many :drivers , join_table: :drivers_vehicles
end
