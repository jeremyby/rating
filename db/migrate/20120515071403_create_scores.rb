class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.float :value
      t.float :previous_score
      t.integer :ratable_id

      t.timestamps
    end
  end
end
