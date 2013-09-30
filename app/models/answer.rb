class Answer < Answerable
  belongs_to :question, :foreign_key => 'askable_id', :class_name => 'Question'
end