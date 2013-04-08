class Ballot < ActiveRecord::Base
  after_create :increment_counters, :log_entry
  after_destroy :decrement_counters

  scope :yes, where("vote = 1")
  scope :no, where("vote = -1")

  attr_accessible :poll_id, :country_code, :vote, :answer


  validates_presence_of :poll_id, :user_id, :country_code, :vote

  validates_inclusion_of :vote, :in => [1, -1]

  validates_uniqueness_of :poll_id, :scope => [:country_code, :user_id]

  belongs_to :poll

  belongs_to :country,  :foreign_key => "country_code",     :primary_key => "code"
  belongs_to :voter,    :foreign_key => "user_id",          :class_name => "User"
  
  has_many :entry_logs
  
  YES_VOTE = 1
  NO_VOTE = -1

  acts_as_commentable

  protected
  def get_counter
    self.vote > 0 ? :yes_count : :no_count
  end

  private
  def increment_counters
    self.poll.increment(:ballots_count).increment(self.get_counter).save!
  end

  def decrement_counters
    self.poll.decrement(:ballots_count).decrement(self.get_counter).save!
  end

  private
  def log_entry
    self.entry_logs.create(
      :kind => 'answer',
      :country_code => self.country_code,
      :poll_id => self.poll_id,
      :user_id => self.user_id
    ) unless self.answer.blank?
  end
end
