class AddColumnsToVehiclesTable < ActiveRecord::Migration[7.0]
  def change
    add_column :vehicles, :vehicle_no, :string
    add_column :vehicles , :driver_id , :integer
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
