class AddColumnToDriversTable < ActiveRecord::Migration[7.0]
  def change
    add_column :drivers, :primary_vehicle_id, :integer
    #Ex:-cle add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
