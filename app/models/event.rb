class Event < ActiveRecord::Base
  scope :new_poll, where(kind: 'poll')
  scope :new_question, where(kind: 'question')
  
  belongs_to :user
  belongs_to :askable
  belongs_to :answerable
  belongs_to :country, :foreign_key => "country_code", :primary_key => "code"
  
  attr_accessible :kind, :askable_id, :country_code, :answerable_id, :user_id, :locales
  
  validates_presence_of :kind, :askable_id, :country_code
end
