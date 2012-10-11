class HomeController < ApplicationController
  def index
    if current_user
      render "users/home"
    else
      @country = Country.find_by_code(country_code_from_request)
      
    end
  end
end
