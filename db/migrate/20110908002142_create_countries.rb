class CreateCountries < ActiveRecord::Migration
  def up
    create_table :countries do |t|
      t.string :slug
      
      t.string :code,               :null => false
      t.string :name,               :null => false
      t.string :pretty_name
      t.string :alias
      t.string :full_name
      t.string :language,           :default => 'en'
      
      t.string :searchable
      
      t.text   :link
      
      t.integer :askables_count
      t.integer :followings_count

      t.timestamps
    end
    
    Country.create_translation_table!({
      :slug => :string,
      :name => :string,
      :full_name => :string,
      :alias => :string,
      :pretty_name  => :string,
      :searchable => :string
    })
    
    add_index :countries, :code, :unique => true
    add_index :countries, :name, :unique => true
    add_index :countries, :slug, :unique => true
  end
  
  def down
    remove_index :countries, :code
    remove_index :countries, :name
    remove_index :countries, :slug
    
    drop_table :countries
    Country.drop_translation_table!
  end
end
