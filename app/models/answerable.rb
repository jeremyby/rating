class Answerable < ActiveRecord::Base
  scope :ballots, where(:type => 'Ballot')
  scope :answers, where(:type => 'Answer')
  
  attr_accessible :askable_id, :country_code, :vote, :body
  after_create :log_event

  validates_presence_of :askable_id, :user_id, :country_code
  validates_uniqueness_of :askable_id, :scope => [:country_code, :user_id]
  
  belongs_to :askable
  belongs_to :user
  belongs_to :country,          :foreign_key => "country_code",     :primary_key => "code"
  
  has_many :events, :dependent => :destroy

  acts_as_commentable

  private
  def log_event
    # when a user answers a question or in a poll
    self.events.create(
      :kind => 'answer',
      :user_id => self.user_id,
      :country_code => self.country_code,
      :askable_id => self.askable_id
    ) unless self.body.blank?
  end
end