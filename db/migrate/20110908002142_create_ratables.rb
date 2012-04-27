class CreateRatables < ActiveRecord::Migration
  def change
    create_table :ratables do |t|
      t.string :type
      t.string :slug
      t.integer :parent_id
      
      t.string :name
      t.string :full_name
      t.text :intro

      t.timestamps
    end

    add_index :ratables, :name, :unique => true
    add_index :ratables, :slug, :unique => true
  end
end
