class CountriesController < ApplicationController
  before_filter :get_country_from_id
  before_filter :set_return_to, :only => [:watch, :unwatch]
  before_filter :require_user, :only => [:watch, :unwatch]

  def show
    @sort = params[:sort]
    %w(recent top).include?(@sort) || @sort = 'recent'
  end

  def watch
    current_user.follow(@country)    
  end

  def unwatch
    current_user.unfollow(@country)

    render 'countries/watch'
  end

  private
  def get_country_from_id
    begin
      @country = Country.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      page_404
    end
  end

  def set_return_to
    @return_to = country_path(@country)
  end
end
