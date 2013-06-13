class QuestionMarkValidator < ActiveModel::Validator
  def validate(record)
    unless record.body.include?('?')
      record.errors[:body] << "should have at least one question mark"
    end
  end
end

class Askable < ActiveRecord::Base
  scope :polls, where(:type => 'Poll')
  scope :questions, where(:type => 'Question')
  
  scope :featured, where(:featured => true)

  attr_accessor :truncate_slug
  
  attr_accessible :user_id, :body, :coverage, :country_code, :description, :yes, :no
  
  after_create :log_event

  validates_presence_of :user_id, :country_code, :coverage

  validates :body,
    :uniqueness => { :scope => :country_code, :message => 'is duplicated' },
    :length => {
      :minimum => 10,
      :maximum => 300,
      :too_long => 'is too long - leave the detail to the description'
    }
    
  validates_length_of :yes, :no, 
    :minimum => 1,
    :maximum => 80,
    :if => Proc.new{|a| a.type == "Poll" }
  
  validates :coverage, :inclusion => { :in => 0..2 }
  validates_with QuestionMarkValidator

  has_many    :followings, :as      => :followable, :dependent => :destroy
  has_many    :followers,  :through => :followings, :source => :user

  
  has_many    :answerables

  belongs_to  :country,   :foreign_key => "country_code",     :primary_key => "code",     :counter_cache => true
  belongs_to  :owner,     :foreign_key => "user_id",          :class_name => "User"
  
  has_many    :events, :dependent => :destroy

  extend FriendlyId
  friendly_id :truncate_slug, :use => :slugged

  acts_as_commentable
  
  Complex_Number = 15

  def truncate_slug
    # b = String.new(self.body)
    # return b.split[0..9].join(" ").downcase.tr("^a-z|^0-9|^\s", "")

    return self.body.truncate(50, :separator => ' ', :omission => '')
  end

  def to_s
    self.body
  end
  
  def more_askables(limit = 4)
    Askable.where("country_code = ? AND id != ?", self.country_code, self.id).order("RAND()").limit(limit)
  end
  
  private
  def log_event
    # when a user creates an askable
    self.events.create(
      :kind => self.type.downcase,
      :user_id => self.user_id,
      :country_code => self.country_code
    )
  end
end