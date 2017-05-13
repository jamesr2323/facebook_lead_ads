class AddPages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.text :name
      t.text :access_token
      t.text :category
      t.integer :facebook_id, :limit => 8, index: true
      t.text :permissions_list
      t.integer :user_id, index: true
      t.timestamps
    end

    change_table :users do |t|
      t.text :first_name
      t.text :last_name
      t.integer :facebook_id, :limit => 8, index: true
      t.text :access_token
      t.timestamp :access_token_expires_at
    end
  end
end
