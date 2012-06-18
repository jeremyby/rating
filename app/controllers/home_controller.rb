class HomeController < ApplicationController
  def index
    @countries = Country.most_polled(10)
  end
end
