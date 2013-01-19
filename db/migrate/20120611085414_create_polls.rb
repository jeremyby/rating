class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string    :slug
      t.string    :question,      :null => false
      t.integer   :votings_count
      
      t.string    :yes,           :default => "Yes",              :null => false
      t.string    :no,            :default => "No",               :null => false
      
      t.integer   :user_id,                                       :null => false
      
      # country the poll is polling
      # 'all' if the poll is applicable to all countries
      t.string    :country_code,                                  :null => false
      
      # polls are categorized into 5 categories, starting from 1, not 0
      # which were initialized in lib
      t.string    :category,                                      :null => false
      
      # 0 for universal - users from all countries can vote for this poll, 
      # 1 for only the polling country
      # 2 for all but the polling country
      t.integer   :coverage,      :default => 0,                  :null => false
            
      # indicate how relevant the poll is to the overall rating of the polling country, 1..10
      # -1 for not approved
      # 0 for waiting for the owner's first vote
      t.integer   :weight,        :default => -1,                 :null => false
      
      t.text  :description
      
      
      t.timestamps
    end
    
    add_index :polls, :user_id
    add_index :polls, :country_code
  end
end
