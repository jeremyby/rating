class Ratable < ActiveRecord::Base
  acts_as_tree
  
  has_many :ratings
  has_one :score
  
  extend FriendlyId
  friendly_id :name, :use => :slugged
  
  
  def rating_score
    return nil if self.score.blank?
    
    case self.score.value
    when 90..100  then return 'AAA'
    when 80..90   then return 'AA'
    when 70..80   then return 'A'
    when 60..70   then return 'BBB'
    when 50..60   then return 'BB'
    when 40..50   then return 'B'
    when 30..40   then return 'CCC'
    when 20..30   then return 'CC'
    when 10..20   then return 'C'
    when 0..10    then return 'D'
    end
  end
  
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
