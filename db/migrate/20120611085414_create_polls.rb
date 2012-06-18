class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string    :slug
      t.string    :question,      :null => false
      t.integer   :votings_count
      
      # positive field can be null, indicting the format: -----------------? or ---?
      t.string    :positive,      :default => "Yes"
      t.string    :negative,      :default => "No"
      
      t.integer   :user_id
      
      # country the poll is polling
      # null if the poll is applicable to all countries
      # if null, the coverage is overridden for it has to be universal as well
      t.string    :country_code,  :default => "all"
      
      # polls are categorized into 5 categories, starting from 1, not 0
      # which were initialized in lib
      t.integer   :category,      :default => 4
      
      # 0 for universal - users from all countries can vote for this poll, 
      # 1 for only the polling country
      # 2 for all but the polling country
      t.integer   :coverage,      :default => 0
            
      # indicate how relevant the poll is to the overall rating of the polling country, 1..10
      # -1 for not approved
      # 0 for waiting for the owner's first vote
      t.integer   :weight,        :default => -1
      
      t.timestamps
    end
  end
end
