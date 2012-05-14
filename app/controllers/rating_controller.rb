class RatingController < ApplicationController
  before_filter :require_user
  before_filter :get_ratable
  
  def new
    @rating = Rating.new
  end

  def create
    @rating = Rating.new( :user => current_user, 
                          :value => get_rate_value, 
                          :ratable_id => @ratable.id)
    if @rating.save
      redirect_to ratable_path(@ratable)
    end
  end

  def edit
    @rating = current_user_rating_for(@ratable)
  end
  
  def update
    @rating = current_user_rating_for(@ratable)
    @rating.value = get_rate_value
    
    if @rating.save
      redirect_to ratable_path(@ratable)
    end
  end
  
  private
  def get_ratable
    @ratable = Ratable.find(params[:ratable_id])
  end
  
  def current_user_rating_for(ratable)
    return Rating.find_by_user_id_and_ratable_id(current_user.id, ratable.id)
  end
  
  def get_rate_value
    return params[:rating][:value].to_f
  end
end