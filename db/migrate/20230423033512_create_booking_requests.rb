class CreateBookingRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :booking_requests do |t|
      t.string :city
      t.string :booking_status
      t.string :vehicle_type
      t.integer :from_location_id
      t.integer :to_location_id
      t.integer :rider_id
      t.string :from_location_name
      t.string :to_location_name

      t.timestamps
    end
  end
end
