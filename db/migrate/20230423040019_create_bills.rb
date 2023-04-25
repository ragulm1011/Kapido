class CreateBills < ActiveRecord::Migration[7.0]
  def change
    create_table :bills do |t|
      t.integer :ride_id
      t.integer :payment_id
      t.date :bill_date

      t.timestamps
    end
  end
end
