class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :phone_number
      t.string :plate_number
      t.integer :status
      t.integer :role
      t.float :rate
      t.string :pin

      t.timestamps
    end
  end
end
