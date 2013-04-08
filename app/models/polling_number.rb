class PollingNumber < ActiveRecord::Base
  attr_accessible :no_count, :yes_count, :date, :country_code
  
  after_create :log_entry
  
  belongs_to :poll
  
  validates :poll_id, :uniqueness => { :scope => :date }, :presence => true
  
  private
  def log_entry
    EntryLog.create(
      :kind => 'majority',
      :poll_id => self.poll_id,
      :country_code => self.country_code
    ) if self.yes_count > self.no_count
    #TODO: testing only now, need to change to -
    #TODO: either one is less than half of the other, or, absolute majority. 33 vs 66
  end  
end
