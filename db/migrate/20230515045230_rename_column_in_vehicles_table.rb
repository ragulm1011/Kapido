class RenameColumnInVehiclesTable < ActiveRecord::Migration[7.0]
  def change
    rename_column :vehicles, :driver_id , :driver_no
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
