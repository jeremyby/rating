class CreateFacts < ActiveRecord::Migration
  def change
    create_table :facts do |t|
      t.string :value
      t.integer :country_id

      t.timestamps
    end
    
    add_index :facts, :country_id 
  end
end
