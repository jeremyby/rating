class CreateFollowings < ActiveRecord::Migration
  def change
    create_table :followings do |t|
      t.integer :user_id,     :null => false
      t.integer :followable_id
      t.string :followable_type

      t.timestamps
    end
    
    add_index :followings, :user_id
    add_index :followings, [:followable_id, :followable_type]
  end
end
