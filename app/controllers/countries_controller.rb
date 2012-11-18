class CountriesController < ApplicationController
  before_filter :require_user_redirect_country, :only => [:follow, :unfollow]
  before_filter :xhr_check, :only => [:follow, :unfollow]
  before_filter :get_country_from_id
  
  def index
  end
  
  def show

  end
  
  def follow
    current_user.watch(@country)
    
    render :partial => 'countries/follow'
  end
  
  def unfollow
    current_user.unwatch(@country)

    render :partial => 'countries/follow'
  end
  
  private
  def get_country_from_id
    begin
      @country = Country.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      #TODO: need to replace default 404 page
      redirect_to '/404.html'
    end
  end
  
  def require_user_redirect_country
    unless current_user
      c = Country.find(params[:id])
      page_404 if c.blank?
      
      store_location(country_path(c))
      flash[:alert] = "You must be logged in to access this page"
      redirect_to "/login"
      return false
    end
  end
end
