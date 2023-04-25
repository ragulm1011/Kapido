class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.integer :rider_id
      t.integer :driver_id
      t.string :mode_of_payment
      t.integer :amount
      t.string :credentials
      t.string :remarks
      t.date :payment_date

      t.timestamps
    end
  end
end
