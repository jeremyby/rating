class HomeController < ApplicationController
  def index
    if current_user
      render 'users/home'
    else
      @country = Country.find_by_code(country_code_from_request)
      
      unless Available_Countries.include?(@country.code)
        flash.now[:notice] = "Sorry we don't provide service for #{@country} yet. But you can <a href='/#{@country.slug}'>help to activate it</a>"
        @country = Country.find_by_code('us')
      end
    end
  end
  
  def about
    
  end
  
  def search
    @countries = Country.order('polls_count DESC')
    
    respond_to do |format|
      format.js
    end
  end
end
