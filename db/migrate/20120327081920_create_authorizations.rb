class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.string :provider,     :null => false
      t.string :uid,          :null => false
      t.integer :user_id,     :null => false
      t.text :token,          :null => false
      t.text :link,           :null => false

      t.timestamps
    end
    
    add_index :authorizations, :user_id
  end
end
