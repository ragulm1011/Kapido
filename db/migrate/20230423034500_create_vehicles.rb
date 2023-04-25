class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :vehicle_name
      t.string :vehicle_type
      t.integer :no_of_seats

      t.timestamps
    end
  end
end
