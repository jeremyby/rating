class Ratable < ActiveRecord::Base
  acts_as_tree
  
  has_many :ratings
  has_one :score
  
  extend FriendlyId
  friendly_id :name, :use => :slugged
  
  def self.inherited(child)
    child.instance_eval do
      alias :original_model_name :model_name
      def model_name
        Ratable.model_name
      end
    end
    super
  end
end
