class Dbgraph < ActiveRecord::Base
  belongs_to :country
  
  attr_accessible :value
end
