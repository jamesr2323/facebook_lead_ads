class AddForwardUrl < ActiveRecord::Migration
  def change
    change_table :pages do |t|
      t.text :webhook_url
    end
  end
end
