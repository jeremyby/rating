class Result < ActiveRecord::Base
  attr_accessible :yes_count, :no_count, :date, :country_code
  
  belongs_to :poll
  validates :poll_id, :uniqueness => { :scope => :date }, :presence => true
  
  after_create :log_event
  
  private
  def log_event
    # while recording the polling results every day, if a majority is reached, note there is no user id
    Event.create(
      :kind => 'majority',
      :askable_id => self.poll_id,
      :country_code => self.country_code
    ) if self.yes_count > self.no_count
    #TODO: testing only now, need to change to
    # either one is less than half of the other, or absolute majority. 33 vs 66
  end  
end
