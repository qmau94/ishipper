class CreateInvoiceHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :invoice_histories do |t|
      t.string :name
      t.string :address
      t.string :delivery_time
      t.float :distance
      t.string :description
      t.float :price
      t.float :shipping_price
      t.float :weight
      t.integer :status
      t.integer :invoice_id

      t.timestamps
    end
  end
end
