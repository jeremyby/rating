class Voting < ActiveRecord::Base
  after_create :increment_counters
  after_destroy :decrement_counters
  
  scope :yes, where("vote = 1")
  scope :no, where("vote = -1")
  
  attr_accessible :poll_id, :country_code, :vote, :explain
  
  validates_presence_of :poll_id, :user_id, :country_code, :vote
  
  validates_inclusion_of :vote, :in => [1, -1]
  
  validates_uniqueness_of :poll_id, :scope => [:country_code, :user_id]
  
  belongs_to :poll

  belongs_to :country,  :foreign_key => "country_code",     :primary_key => "code"
  belongs_to :voter,    :foreign_key => "user_id",          :class_name => "User"
  
  YES_VOTE = 1
  NO_VOTE = -1
  
  acts_as_commentable
  
  protected
  def get_counter
    self.vote > 0 ? :yes_votings_count : :no_votings_count
  end
  
  private
  def increment_counters
    self.poll.increment(:votings_count).increment(self.get_counter).save!
  end
  
  def decrement_counters
    self.poll.decrement(:votings_count).decrement(self.get_counter).save!
  end
end
