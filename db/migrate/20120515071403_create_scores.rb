class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.float :value,           :null => false, :default => 50.0
      t.float :previous_score
      t.integer :ratable_id

      t.timestamps
    end
  end
end
