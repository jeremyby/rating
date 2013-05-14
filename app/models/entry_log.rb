class EntryLog < ActiveRecord::Base
  attr_accessible :askable_id, :country_code, :answerable_id, :user_id, :kind
  
  belongs_to :askable
  belongs_to :user
  belongs_to :answerable
  belongs_to :country,  :foreign_key => "country_code",     :primary_key => "code"
end
