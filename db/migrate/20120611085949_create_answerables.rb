class CreateAnswerables < ActiveRecord::Migration
  def up
    create_table :answerables do |t|
      t.string      :type
      
      t.integer     :askable_id,              :null => false
      t.integer     :user_id,                 :null => false
      t.string      :country_code,            :null => false
      
      t.text        :body
      t.string      :auto_translated
      
      # users' vote in a poll = a ballot
      #  1 => yes
      # -1 => no 
      t.integer     :vote
      
      t.timestamps
    end
    
    Answerable.create_translation_table!({
      :body => :text,
      :auto_translated => :string
    })
    
    add_index :answerables, :askable_id
    add_index :answerables, :user_id
    add_index :answerables, :country_code
    add_index :answerables, [:user_id, :askable_id, :country_code], :unique => true
  end
  
  def down
    remove_index :answerables, :askable_id
    remove_index :answerables, :user_id
    remove_index :answerables, :country_code
    remove_index :answerables, [:user_id, :askable_id, :country_code]
    
    Answerable.drop_translation_table!
    
    drop_table :answerables
  end
end
