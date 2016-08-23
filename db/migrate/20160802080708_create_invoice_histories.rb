class CreateInvoiceHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :invoice_histories do |t|
      t.string :name
      t.string :address_start
      t.float :latitude_start
      t.float :longitude_start
      t.string :address_finish
      t.float :latitude_finish
      t.float :longitude_finish
      t.string :delivery_time
      t.float :distance
      t.string :description
      t.float :price
      t.float :shipping_price
      t.integer :status
      t.float :weight
      t.string :customer_name
      t.string :customer_number
      t.integer :invoice_id

      t.timestamps null: false
    end
  end
end
