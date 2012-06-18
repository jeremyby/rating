class CountriesController < ApplicationController
  def index
  end
  
  def show
    begin
      @country = Country.find(params[:country_id])   
    rescue ActiveRecord::RecordNotFound
      redirect_to '/404.html'
    end
  end    
end
