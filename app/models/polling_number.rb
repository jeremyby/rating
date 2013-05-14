class PollingNumber < ActiveRecord::Base
  attr_accessible :yes_count, :no_count, :date, :country_code
  
  belongs_to :poll
  validates :poll_id, :uniqueness => { :scope => :date }, :presence => true
  
  after_create :log_entry
  
  private
  def log_entry
    EntryLog.create(
      :kind => 'Majority',
      :askable_id => self.poll_id,
      :country_code => self.country_code
    ) if self.yes_count > self.no_count
    #TODO: testing only now, need to change to
    #TODO: either one is less than half of the other, or absolute majority. 33 vs 66
  end  
end
