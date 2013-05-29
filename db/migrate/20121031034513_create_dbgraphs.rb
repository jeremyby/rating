class CreateDbgraphs < ActiveRecord::Migration
  def change
    create_table :dbgraphs do |t|
      t.text :value, :limit => 4.gigabytes - 1
      t.integer :country_id

      t.timestamps
    end
    
    add_index :dbgraphs, :country_id, :unique => true
  end
end
