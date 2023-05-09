class AddColumnToRidesTable < ActiveRecord::Migration[7.0]
  def change
    add_column :rides, :ride_status, :string
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
