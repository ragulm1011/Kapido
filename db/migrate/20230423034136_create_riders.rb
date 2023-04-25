class CreateRiders < ActiveRecord::Migration[7.0]
  def change
    create_table :riders do |t|
      t.string :gender
      t.string :aadhar_no

      t.timestamps
    end
  end
end
