class AddColumnsToDriversAndRidersTable < ActiveRecord::Migration[7.0]
  def change
    add_column :drivers, :current_ride_id , :integer
    add_column :riders , :current_ride_id , :integer
  end
end
