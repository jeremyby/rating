class Answer < Answerable
  belongs_to :question, :foreign_key => 'askable_id', :class_name => 'Question'
  
  def update_from(params)
    self.update_attributes!(:body => params[:body])
  end
end