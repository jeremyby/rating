class CreateRatables < ActiveRecord::Migration
  def change
    create_table :ratables do |t|
      t.string :type,               :null => false
      t.string :slug
      t.integer :parent_id
      
      t.string :code
      t.string :name,               :null => false
      t.string :alias
      t.string :full_name

      t.timestamps
    end
    
    add_index :ratables, :code, :unique => true
    add_index :ratables, :name, :unique => true
    add_index :ratables, :slug, :unique => true
  end
end
