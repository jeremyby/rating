class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :poll_id
      t.integer :yes_count
      t.integer :no_count
      t.string  :country_code
      t.string  :date

      t.timestamps
    end
    
    add_index :results, :poll_id
  end
end
