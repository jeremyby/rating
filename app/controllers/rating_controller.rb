class RatingController < ApplicationController
  before_filter :require_user, :only => [:new, :create]
  before_filter :get_ratable
  
  def new
    @rating = Rating.new
  end

  def create
    rate_value = params[:rating][:value]
    @rating = Rating.new(:user => current_user, :value => rate_value.to_f, :ratable_id => @ratable.id)
    if @rating.save
      render :action => :show
    end
  end

  def show
  end
  
  private
  def get_ratable
    @ratable = Ratable.find(params[:ratable_id])
  end
  
end