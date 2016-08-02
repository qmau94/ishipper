class CreateUserInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :user_invoices do |t|
      t.integer :status
      t.references :user, foreign_key: true
      t.references :invoice, foreign_key: true

      t.timestamps
    end
  end
end
