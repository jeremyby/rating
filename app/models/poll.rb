class Poll < ActiveRecord::Base
  scope :approved, where("weight > 0")
  scope :featured, where(:featured => true)
  
  attr_accessor :question_reformat
  
  attr_accessible :question, :category, :coverage, :yes, :no, :positive_no, :country_code, :weight, :user_id
  
  validates_presence_of :user_id, :question, :country_code, :category, :coverage, :weight
  validates_uniqueness_of :question
  validates_exclusion_of :category, :in => %w( nil ), :message => "need to be a valid category"
  
  has_many    :votings
  
  belongs_to  :country,   :foreign_key => "country_code",     :primary_key => "code",     :counter_cache => true
  belongs_to  :owner,     :foreign_key => "user_id",          :class_name => "User"
  
  extend FriendlyId
  friendly_id :question_reformat, :use => :slugged
  
  acts_as_commentable
  
  def question_reformat
    q = String.new(self.question)

    return q.split[0..9].join(" ").downcase.tr("^a-z|^0-9|^\s", "")
  end
  
  def assign_attributes(values, options = {})
    sanitize_for_mass_assignment(values, options[:as]).each do |k, v|
      send("#{k}=", v)
    end
  end
  
  #********************************************
  #
  #   Business Logic
  #
  #********************************************
  
  def positive
    self.positive_no ? self.no : self.yes
  end
  
  def negative
    self.positive_no ? self.yes : self.no
  end
  
  def yes_votes_size
    self.positive_no ? self.negative_votings_count : self.positive_votings_count
  end
  
  def no_votes_size
    self.positive_no ? self.positive_votings_count : self.negative_votings_count
  end
end
