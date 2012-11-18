class HomeController < ApplicationController
  def index
    if current_user
      render 'users/home'
    else
      @country = Country.find_by_code(country_code_from_request)
      
      if @country.polls_count.blank?
        @country = Country.find_by_code('us')
      end
    end
  end
  
  def about
    
  end
  
  def search
    @countries = Country.real.order('polls_count DESC')
    
    respond_to do |format|
      format.js
    end
  end
end
