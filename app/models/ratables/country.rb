class Country < Ratable
  validates_presence_of :code, :name
  validates_uniqueness_of :code, :name
  
  def self.top_rated(limit, offset=0)
    Country.includes(:score).joins(:score).order('scores.value DESC').limit(limit).offset(offset)
  end
end