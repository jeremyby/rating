class CreateAskables < ActiveRecord::Migration
  def change
    create_table :askables do |t|
      t.string    :type
      
      # which country is being asked
      t.string    :country_code,      :null => false
      
      t.integer   :followings_count,  :default => 0
      t.integer   :user_id,           :null => false
      
      t.string    :slug
      
      t.text      :body,              :null => false
      
      # 0 for universal - users from all countries can vote for this poll, 
      # 1 for only the polling country
      # 2 for all but the polling country
      t.integer   :coverage,          :default => 0,                  :null => false
      
      t.boolean   :featured,          :default => false
      t.boolean   :locked,            :default => false
      
      t.text      :description
      
      # Poll specific
      t.string    :yes,               :default => "Yes",              :null => false
      t.string    :no,                :default => "No",               :null => false
      
      
      t.timestamps
    end
    
    add_index :askables, :slug, :unique => true
    add_index :askables, :user_id
    add_index :askables, :country_code
  end
end
