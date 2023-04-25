class CreateDriversVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :drivers_vehicles do |t|
      t.integer :driver_id
      t.integer :vehicle_id

      t.timestamps
    end
  end
end
