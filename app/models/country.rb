class Country < ActiveRecord::Base
  has_one :dbgraph
  has_many :facts

  has_many :residents,      :primary_key => "code",     :foreign_key => "country_code",     :class_name => "User"

  has_many :followings,     :as => :followable,         :dependent => :destroy
  has_many :followers,      :through => :followings,    :source => :user

  has_many :askables,       :primary_key => "code",     :foreign_key => "country_code"
  has_many :answerables,    :primary_key => "code",     :foreign_key => "country_code"
  has_many :events,         :primary_key => "code",     :foreign_key => "country_code"

  attr_accessible :code, :name, :full_name, :alias, :pretty_name, :searchable, :language
  
  translates :slug, :name, :full_name, :alias, :pretty_name, :searchable
  extend FriendlyId
  friendly_id :name, :use => :globalize

  validates_presence_of :code, :name
  validates_uniqueness_of :code, :name
  
  def normalize_friendly_id(string)
    string.slugged
  end
  
  def to_s
    self.pretty_name.blank? ? self.name : self.pretty_name
  end
  
  def lookup_string
    self.searchable.blank? ? "#{self.name} #{self.code}" : "#{self.name} #{self.searchable} #{self.code}"
  end

  def self.most_asked(limit, offset=0)
    Country.where("askables_count > 0").order("askables_count DESC").limit(limit).offset(offset)
  end

  def top_askables(limit, offset=0)
    self.askables.order("answerables_count DESC").limit(limit).offset(offset)
  end

  def top_asking_countries
    Country.joins(:residents)
    .joins('LEFT OUTER JOIN askables ON askables.user_id = users.id')
    .where('askables.country_code = ?', self.code)
    .where('users.country_code <> ?', self.code)
    .group('users.country_code')
    .order('COUNT(users.country_code) DESC')
  end

  def random_fact
    facts = self.facts.order("RAND()").limit(1)

    return facts.blank? ? nil : facts.first.value
  end
end
