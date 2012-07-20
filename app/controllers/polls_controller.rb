class PollsController < ApplicationController
  before_filter :require_user, :except => :show
  before_filter :get_country

  def show
    begin        
      @poll = Poll.find(params[:id])
      
      # return anchor for voting controller
      session[:return_to] = request.url
    rescue ActiveRecord::RecordNotFound
      page_404
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
  
  def destroy
  end
end


