class Voting < ActiveRecord::Base
  # attr_accessible :title, :body
  
  validates_presence_of :poll_id, :user_id, :country_code, :vote
  
  #TODO: figure out why validate inclusion does not work
  validates_inclusion_of :vote, :in => [1, -1]
  
  belongs_to :poll,     :counter_cache => true
  belongs_to :country,  :foreign_key => "country_code",     :primary_key => "code"
  belongs_to :voter,    :foreign_key => "user_id",          :class_name => "User"
  
  POSITIVE_VOTE = 1
  NEGATIVE_VOTE = -1
end