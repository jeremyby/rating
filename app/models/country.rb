class Country < ActiveRecord::Base
  scope :real, where("code <> 'all'")
  
  has_one :score
  has_one :dbgraph
  
  has_many :facts
  
  has_many :residents,  :primary_key => "code",     :foreign_key => "country_code",     :class_name => "User"
  
  has_many :followings, :as => :followable, :dependent => :destroy
  has_many :followers, :through => :followings, :source => :user

  
  has_many :polls,      :primary_key => "code",     :foreign_key => "country_code"
  has_many :votings,    :primary_key => "code",     :foreign_key => "country_code"
  
  attr_accessible :code, :name, :full_name, :alias
  
  extend FriendlyId
  friendly_id :name, :use => :slugged
  
  validates_presence_of :code, :name
  validates_uniqueness_of :code, :name
  
  def to_s
    self.pretty_name.present? ? self.pretty_name : self.name
  end
  
  def self.most_polled(limit, offset=0)
    Country.real.where("polls_count > 0").order("polls_count DESC").limit(limit).offset(offset)
  end
  
  
  def top_polls(limit, offset=0)
    self.polls.approved.order("votings_count DESC").limit(limit).offset(offset)
  end
  
  
  def top_asking_countries
    Country.joins(:residents)
            .joins('LEFT OUTER JOIN polls ON polls.user_id = users.id')
            .where('polls.country_code = ?', self.code)
            .where('users.country_code <> ?', self.code)
            .group('users.country_code')
            .order('COUNT(users.country_code) DESC')
  end
    
    
  def random_fact
    facts = self.facts
    
    facts[rand(facts.size) - 1].value
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
