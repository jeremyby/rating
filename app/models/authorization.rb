class Authorization < ActiveRecord::Base
  belongs_to :user
  attr_accessible :provider, :uid, :token, :link
  
  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider
end
