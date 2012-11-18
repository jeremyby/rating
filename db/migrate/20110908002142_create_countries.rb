class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :slug
      
      t.string :code,               :null => false
      t.string :name,               :null => false
      t.string :pretty_name
      t.string :alias
      t.string :full_name
      
      t.text   :link
      
      t.integer :polls_count
      t.integer :watchings_count

      t.timestamps
    end
    
    add_index :countries, :code, :unique => true
    add_index :countries, :name, :unique => true
    add_index :countries, :slug, :unique => true
  end
end
