class HomeController < ApplicationController
  def index
    @countries = Country.top_rated(10)
  end
end
