class AddColumnToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :text
    add_column :users, :profile, :text
    add_column :users, :profile_image_id, :text
    add_column :users, :twitter, :text
    add_column :users, :facebook, :text
    add_column :users, :website, :text
  end
end