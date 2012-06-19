class PollsController < ApplicationController
  def index
  end

  def show
    begin        
      @country = Country.find(params[:country_id])
      @poll = Poll.find(params[:id])     
    rescue ActiveRecord::RecordNotFound
      #TODO: need to replace default 404 page
      redirect_to '/404.html'
    end
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end
end


