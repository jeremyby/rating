class CreateAnswerables < ActiveRecord::Migration
  def change
    create_table :answerables do |t|
      t.string      :type
      
      t.integer     :askable_id,              :null => false
      t.integer     :user_id,                 :null => false
      t.string      :country_code,            :null => false
      
      t.text        :body
      
      # users' vote in a poll = a ballot
      #  1 => yes
      # -1 => no 
      t.integer     :vote,                    :null => false
      
      t.timestamps
    end
    
    add_index :answerables, :askable_id
    add_index :answerables, :user_id
    add_index :answerables, :country_code
    add_index :answerables, [:user_id, :askable_id, :country_code], :unique => true
  end
end
