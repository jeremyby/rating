class Voting < ActiveRecord::Base
  after_create :increment_counters
  after_destroy :decrement_counters
  
  scope :positive, where("vote = 1")
  scope :negative, where("vote = -1")
  
  validates_presence_of :poll_id, :user_id, :country_code, :vote
  
  #TODO: figure out why validate inclusion does not work
  validates_inclusion_of :vote, :in => [1, -1]
  
  belongs_to :poll

  belongs_to :country,  :foreign_key => "country_code",     :primary_key => "code"
  belongs_to :voter,    :foreign_key => "user_id",          :class_name => "User"
  
  POSITIVE_VOTE = 1
  NEGATIVE_VOTE = -1
  
  
  protected
  def get_counter
    self.vote > 0 ? :positive_votings_count : :negative_votings_count
  end
  
  private
  def increment_counters
    self.poll.increment(:votings_count).increment(self.get_counter).save!
  end
  
  def decrement_counters
    self.poll.decrement(:votings_count).decrement(self.get_counter).save!
  end
end
