class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :slug
      t.integer :parent_id
      
      t.string :code
      t.string :name,               :null => false
      t.string :alias
      t.string :full_name
      
      t.integer :polls_count

      t.timestamps
    end
    
    add_index :countries, :code, :unique => true
    add_index :countries, :name, :unique => true
    add_index :countries, :slug, :unique => true
  end
end
