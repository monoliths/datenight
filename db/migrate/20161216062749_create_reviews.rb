class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer :user_id, required: true, null: false
      t.integer :place_id, required: true, null: false
      t.text :content, required: true, null: false

      t.timestamps
    end
  end
end
