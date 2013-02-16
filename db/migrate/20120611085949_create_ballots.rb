class CreateBallots < ActiveRecord::Migration
  def change
    create_table :ballots do |t|
      t.integer     :poll_id,                 :null => false
      t.integer     :user_id,                 :null => false
      t.string      :country_code,            :null => false
      t.text        :answer
      
      # users' vote on a poll question
      #  1 => yes
      # -1 => no 
      t.integer     :vote,                    :null => false
      
      t.timestamps
    end
    
    add_index :ballots, :poll_id
    add_index :ballots, :user_id
    add_index :ballots, :country_code
    add_index :ballots, [:user_id, :poll_id, :country_code], :unique => true
  end
end
