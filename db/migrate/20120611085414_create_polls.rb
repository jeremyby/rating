class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string    :slug
      t.string    :question,      :null => false
      t.integer   :ballots_count, :default => 0
      t.integer   :yes_count, :default => 0
      t.integer   :no_count, :default => 0
      
      t.integer   :followings_count
      
      t.string    :yes,           :default => "Yes",              :null => false
      t.string    :no,            :default => "No",               :null => false
      
      t.integer   :user_id,                                       :null => false
      
      # country the poll is polling
      # 'all' if the poll is applicable to all countries
      t.string    :country_code,                                  :null => false
      
      # 0 for universal - users from all countries can vote for this poll, 
      # 1 for only the polling country
      # 2 for all but the polling country
      t.integer   :coverage,      :default => 0,                  :null => false
      
      t.text  :description
      
      t.timestamps
    end
    
    add_index :polls, :user_id
    add_index :polls, :country_code
  end
end
