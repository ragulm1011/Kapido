class CreateRides < ActiveRecord::Migration[7.0]
  def change
    create_table :rides do |t|
      t.integer :rider_id
      t.integer :driver_id
      t.integer :booking_request_id
      t.date :ride_date

      t.timestamps
    end
  end
end
