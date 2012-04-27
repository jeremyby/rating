class Rating < ActiveRecord::Base
  acts_as_versioned :table_name => :rating_versions
  
  belongs_to :user
  belongs_to :ratable
end
