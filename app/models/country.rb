class Country < ActiveRecord::Base
  scope :available, where(:code => Available_Countries)
  scope :unavailable, where('code not in (?)', Available_Countries)
  
  has_one :dbgraph
  has_many :facts

  has_many :residents,      :primary_key => "code",     :foreign_key => "country_code",     :class_name => "User"

  has_many :followings,     :as => :followable,         :dependent => :destroy
  has_many :followers,      :through => :followings,    :source => :user

  has_many :polls,          :primary_key => "code",     :foreign_key => "country_code"
  has_many :ballots,        :primary_key => "code",     :foreign_key => "country_code"
  
  has_many :entry_logs,     :primary_key => "code",     :foreign_key => "country_code"

  attr_accessible :code, :name, :full_name, :alias, :pretty_name

  extend FriendlyId
  friendly_id :name, :use => :slugged

  validates_presence_of :code, :name
  validates_uniqueness_of :code, :name

  def to_s
    self.pretty_name.present? ? self.pretty_name : self.name
  end

  def self.most_polled(limit, offset=0)
    Country.where("polls_count > 0").order("polls_count DESC").limit(limit).offset(offset)
  end

  def top_polls(limit, offset=0)
    self.polls.order("ballots_count DESC").limit(limit).offset(offset)
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
end
