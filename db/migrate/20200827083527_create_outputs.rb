class CreateOutputs < ActiveRecord::Migration[6.0]
  def change
    create_table :outputs do |t|
      t.integer :user_id
      t.integer :book_id
      t.text :body
      t.timestamps
    end
  end
end