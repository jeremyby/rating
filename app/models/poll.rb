class Poll < ActiveRecord::Base
  scope :approved, where("weight > 0")
  scope :featured, where(:featured => true)
  
  attr_accessor :question_reformat
  
  #TODO: need to restrict mass assignment below
  # attr_accessible :title, :body
  
  validates_presence_of :user_id, :question, :country_code, :category, :coverage, :weight
  validates_uniqueness_of :question
  
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
  
  
  #********************************************
  #
  #   Business Logic
  #
  #********************************************
  
  def positive
    self.yes_positive ? self.yes : self.no
  end
  
  def negative
    self.yes_positive ? self.no : self.yes
  end
  
  def yes_votes_size
    self.yes_positive ? self.positive_votings_count : self.negative_votings_count
  end
  
  def no_votes_size
    self.yes_positive ? self.negative_votings_count : self.positive_votings_count
  end
end
