class PollCategory
  attr_accessor :code, :name
  
  def initialize(code, name)
    @code = code
    @name = name
  end
end