class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer :owner_id
      t.integer :recipient_id
      t.string :key

      t.timestamps
    end
  end
end
