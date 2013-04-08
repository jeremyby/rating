class CreatePollingNumbers < ActiveRecord::Migration
  def change
    create_table :polling_numbers do |t|
      t.integer :poll_id
      t.integer :yes_count
      t.integer :no_count
      t.string  :country_code
      t.string  :date

      t.timestamps
    end
    
    add_index :polling_numbers, :poll_id
  end
end
