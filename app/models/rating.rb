class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :country
  
  after_save :update_country_score
  
  private
  def update_country_score
    c = self.country
    
    # Only generating scores for countries that have been rated a certain times. 
    return nil unless c.ratings.size >= 1

    score = Score.where(:country_id => c.id).first_or_initialize
    score.previous_score = score.value
    score.value = c.ratings.average('value').floor(1).to_f
    score.save
  end
end
