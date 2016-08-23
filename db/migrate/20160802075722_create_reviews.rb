class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer :owner_id
      t.integer :recipient_id
      t.references :invoice, foreign_key: true
      t.integer :review_type
      t.float :rating_point
      t.string :content

      t.timestamps
    end
  end
end
