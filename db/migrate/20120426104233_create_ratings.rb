class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.integer :value
      t.integer :user_id
      t.integer :ratable_id
      t.integer :version

      t.timestamps
    end
    Rating.create_versioned_table
  end
  def self.down
    drop_table :ratings
    Raing.drop_versioned_table
  end
end
