class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string  :kind,            :null => false
      
      t.string  :country_code,    :null => false
      t.integer :askable_id,      :null => false
      t.integer :user_id
      t.integer :answerable_id
      
      t.timestamps
    end
    
    add_index :events, :country_code
    add_index :events, :askable_id
    add_index :events, [:country_code, :askable_id, :user_id]
  end
end
