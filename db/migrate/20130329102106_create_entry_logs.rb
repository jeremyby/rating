class CreateEntryLogs < ActiveRecord::Migration
  def change
    create_table :entry_logs do |t|
      t.string  :kind,         :null => false
      t.string  :country_code
      t.integer :poll_id,       :null => false
      t.integer :user_id
      t.integer :ballot_id

      t.timestamps
    end
    
    add_index :entry_logs, :country_code
    add_index :entry_logs, :poll_id
    add_index :entry_logs, [:country_code, :poll_id, :user_id]
  end
end
