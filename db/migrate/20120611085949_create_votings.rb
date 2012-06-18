class CreateVotings < ActiveRecord::Migration
  def change
    create_table :votings do |t|
      t.integer     :poll_id
      t.integer     :user_id
      t.string      :country_code
      
      # users' vote on a poll question
      #  1 => positive
      # -1 => negative 
      t.integer     :vote
      
      t.timestamps
    end
  end
end
