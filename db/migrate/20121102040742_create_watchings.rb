class CreateWatchings < ActiveRecord::Migration
  def change
    create_table :watchings do |t|
      t.integer :user_id
      t.string :country_code
      t.string :knowledge

      t.timestamps
    end
    
    add_index :watchings, :user_id
    add_index :watchings, :country_code
    add_index :watchings, [:user_id, :country_code], :unique => true
  end
end
