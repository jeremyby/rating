class EntryLog < ActiveRecord::Base
  attr_accessible :ballot_id, :country_code, :poll_id, :user_id, :kind
  
  belongs_to :poll
  belongs_to :user
  belongs_to :ballot
  belongs_to :country,  :foreign_key => "country_code",     :primary_key => "code"
end
