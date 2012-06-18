class Country < ActiveRecord::Base
  has_many :ratings
  has_one :score
  
  has_many :polls,      :primary_key => "code",     :foreign_key => "country_code"
  has_many :votings,    :primary_key => "code",     :foreign_key => "country_code"
  
  extend FriendlyId
  friendly_id :name, :use => :slugged
  
  validates_presence_of :code, :name
  validates_uniqueness_of :code, :name
  
  def self.most_polled(limit, offset=0)
    Country.where("polls_count > 0 AND code <> 'all'").order("polls_count DESC").limit(limit).offset(offset)
  end
  
  def self.top_rated(limit, offset=0)
    Country.includes(:score).joins(:score).order('scores.value DESC').limit(limit).offset(offset)
  end
  
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
end
