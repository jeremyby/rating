class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :ratable
  
  after_save :update_ratable_score
  
  private
  def update_ratable_score
    ratable = self.ratable
    score = Score.where(:ratable_id => ratable.id).first_or_create
    score.previous_score = score.value
    score.value = ratable.ratings.average('value').floor(1).to_f
    score.save
  end
end
