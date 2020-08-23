class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.text :title,                null: false, default: ""
      t.text :body,                 null: false, default: ""
      t.string :book_image_id
      t.text :amazon_url,           default: ""
      t.text :rakuten_url,          default: ""
      t.timestamps
    end
  end
end