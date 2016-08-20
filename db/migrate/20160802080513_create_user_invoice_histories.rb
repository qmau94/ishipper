class CreateUserInvoiceHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :user_invoice_histories do |t|
      t.integer :status
      t.integer :user_invoice_id

      t.timestamps
    end
  end
end
