class AddColumnToDriversTable1 < ActiveRecord::Migration[7.0]
  def change
    add_column :drivers, :riding_status, :string
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
