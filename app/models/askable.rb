
class QuestionMarkValidator < ActiveModel::Validator
  def validate(record)
     unless record.body.present? && ( record.body.include?('?') || record.body.include?('？') )
      record.errors[:body] << "should have at least one question mark"
    end
  end
end

class Askable < ActiveRecord::Base
  scope :polls, where(:type => 'Poll')
  scope :questions, where(:type => 'Question')
  
  scope :featured, where(:featured => true)
  
  attr_accessible :user_id, :body, :coverage, :country_code, :description, :yes, :no, :auto_translated
  
  after_create :log_event

  validates_presence_of :user_id, :country_code, :coverage

  validates :body,
    :uniqueness => { :scope => :country_code, :message => 'is duplicated' },
    :length => {
      :minimum => 5,
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
  
  translates :slug, :body, :yes, :no, :description, :auto_translated, :versioning => true 
  extend FriendlyId
  friendly_id :body, :use => [:globalize, :history]
  
  acts_as_translateable
  acts_as_commentable
  
  Complex_Number = 15
  
  def normalize_friendly_id(string)
    string[0..79].slugged
  end
  
  def more_askables(limit = 4)
    Askable.includes(:translations)
      .where('askable_translations.locale = ? AND country_code = ? AND askables.id != ?', I18n.locale, self.country_code, self.id)
      .order("RAND()")
      .limit(limit)
  end
  
  private
  def log_event
    # when a user creates an askable
    self.events.create(
      :kind => self.type.downcase,
      :user_id => self.user_id,
      :country_code => self.country_code,
      :locales => I18n.locale.to_s
    )
  end
end