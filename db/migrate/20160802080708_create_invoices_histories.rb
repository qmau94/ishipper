class CreateInvoicesHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices_histories do |t|
      t.string :name
      t.string :address
      t.string :delivery_time
      t.float :distance
      t.string :description
      t.float :price
      t.float :shipping_price
      t.float :weight
      t.integer :status
      t.references :invoice, foreign_key: true

      t.timestamps
    end
  end
end
