class RatingController < ApplicationController
  before_filter :require_user
  before_filter :find_country
  
  def new
    @rating = Rating.new
  end

  def create
    @rating = Rating.new( :user => current_user, 
                          :value => get_rate_value, 
                          :country_id => @country.id)
    if @rating.save
      redirect_to country_path(@country)
    end
  end

  def edit
    @rating = current_user_rating_for(@country)
  end
  
  def update
    @rating = current_user_rating_for(@country)
    @rating.value = get_rate_value
    
    if @rating.save
      redirect_to country_path(@country)
    end
  end
  
  private
  def find_country
    @country = Country.find(params[:country_id])
  end
  
  def current_user_rating_for(country)
    return Rating.find_by_user_id_and_country_id(current_user.id, country.id)
  end
  
  def get_rate_value
    return params[:rating][:value].to_f
  end
end