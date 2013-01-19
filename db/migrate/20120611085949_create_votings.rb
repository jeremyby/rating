class CreateVotings < ActiveRecord::Migration
  def change
    create_table :votings do |t|
      t.integer     :poll_id,                 :null => false
      t.integer     :user_id,                 :null => false
      t.string      :country_code,            :null => false
      
      # users' vote on a poll question
      #  1 => yes
      # -1 => no 
      t.integer     :vote,                    :null => false
      
      t.timestamps
    end
    
    add_index :votings, :poll_id
    add_index :votings, :user_id
    add_index :votings, :country_code
    add_index :votings, [:user_id, :poll_id], :unique => true
  end
end
