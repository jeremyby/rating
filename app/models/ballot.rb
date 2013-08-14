class Ballot < Answerable
  scope :yes, where("vote = 1")
  scope :no, where("vote = -1")
  
  belongs_to :poll, :foreign_key => 'askable_id', :class_name => 'Poll'
  
  YES_VOTE = 1
  NO_VOTE = -1
  
  def update_from(params)
    self.update_attributes!(:vote => params[:vote], :body => params[:body])
  end
end