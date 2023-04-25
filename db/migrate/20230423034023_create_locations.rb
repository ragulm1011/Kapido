class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :location_name
      t.string :landmark
      t.string :city
      t.integer :pincode

      t.timestamps
    end
  end
end
