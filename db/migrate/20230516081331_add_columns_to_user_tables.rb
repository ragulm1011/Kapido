class AddColumnsToUserTables < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :door_no, :string
    add_column :users, :street, :string
    add_column :users, :city, :string
    add_column :users, :district, :string
    add_column :users, :state, :string
    add_column :users, :pincode, :integer
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
