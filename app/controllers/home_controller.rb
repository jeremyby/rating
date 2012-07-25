class HomeController < ApplicationController
  def index
    @home_logo_display = true
    @countries = Country.most_polled(10)
  end
end
