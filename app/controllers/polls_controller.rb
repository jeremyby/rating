class PollsController < ApplicationController
  before_filter :require_user, :except => :show
  before_filter :get_country
  
  def new
    @poll = Poll.new
  end

  def create
    poll = Poll.new(params[:poll])
    
    raise poll.inspect
  end

  def edit
  end

  def update
  end
  
  def destroy
  end

  def show
    begin        
      @poll = Poll.find(params[:id])
      
      @complex = @poll.voting_complex if @poll.votings.size > 10
      
      # return anchor for voting controller
      # session[:return_to] = request.url
    rescue ActiveRecord::RecordNotFound
      page_404
    end
  end
  
  private
  def get_country_new_poll
    @country = Country.find(params[:country_id]) if params[:country_id].present?
  end
end


