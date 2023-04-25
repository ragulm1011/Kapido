class CreateDrivers < ActiveRecord::Migration[7.0]
  def change
    create_table :drivers do |t|
      t.string :liscense_no
      t.float :driver_rating
      t.string :standby_city

      t.timestamps
    end
  end
end
