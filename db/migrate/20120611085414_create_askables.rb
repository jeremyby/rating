class CreateAskables < ActiveRecord::Migration
  def up
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
      t.integer   :coverage,          :null => false,                 :default => 0
      
      t.boolean   :featured,          :default => false
      t.boolean   :locked,            :default => false
      
      t.string    :auto_translated
      
      t.text      :description
      
      # Poll specific
      t.string    :yes,               :default => I18n.t('ans_yes')
      t.string    :no,                :default => I18n.t('ans_no')
      
      t.timestamps
    end
    
    Askable.create_translation_table!({
      :slug => :string,
      :body => :text,
      :description => :text,
      :yes => :string,
      :no => :string,
      :auto_translated => :string
    })
    
    add_index :askables, :slug, :unique => true
    add_index :askables, :user_id
    add_index :askables, :country_code
  end
  
  def down
    remove_index :askables, :slug
    remove_index :askables, :user_id
    remove_index :askables, :country_code
    
    Askable.drop_translation_table!
    
    drop_table :askables
  end
end
