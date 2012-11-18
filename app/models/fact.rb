class Fact < ActiveRecord::Base
  belongs_to :country
  
  attr_accessible :value
end
