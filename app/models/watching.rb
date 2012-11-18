class Watching < ActiveRecord::Base
  attr_accessible :country_code
  
  belongs_to :watcher, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :watching_country, :class_name => 'Country', :foreign_key => 'country_code', :primary_key => "code", :counter_cache => true
end
