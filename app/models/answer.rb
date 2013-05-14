class Answer < Answerable
  validates :body, :length => {
    :minimum   => 3,
    :maximum   => 1000,
    :tokenizer => lambda { |str| str.scan(/\w+/) },
    :too_short => "must have at least %{count} words",
    :too_long  => "must have at most %{count} words"
  }
  
  belongs_to :question, :foreign_key => 'askable_id', :class_name => 'Question'
end