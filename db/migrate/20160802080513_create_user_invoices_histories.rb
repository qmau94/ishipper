class CreateUserInvoicesHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :user_invoices_histories do |t|
      t.integer :status
      t.references :user_invoice, foreign_key: true

      t.timestamps
    end
  end
end
