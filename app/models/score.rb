class Score < ActiveRecord::Base
  validates_presence_of :value
  
  belongs_to :ratable
end
