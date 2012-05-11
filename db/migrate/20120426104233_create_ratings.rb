class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.float :value
      t.integer :user_id
      t.integer :ratable_id

      t.timestamps
    end
  end
end
