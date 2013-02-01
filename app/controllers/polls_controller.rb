class PollsController < ApplicationController
  before_filter :get_country
  before_filter :set_return_to, :only => [:follow, :unfollow]
  before_filter :require_user, :except => :show
  

  
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
      
      current_user_id = current_user.present? ? current_user.id : 0
      
      @complex = @poll.voting_complex(current_user_id) if @poll.votings.size > 10

    rescue ActiveRecord::RecordNotFound
      page_404
    end
  end
  
  def follow
    @poll = Poll.find(params[:id])
    
    current_user.follow(@poll)
  end

  def unfollow
    @poll = Poll.find(params[:id])
    
    current_user.unfollow(@poll)

    render 'polls/follow'
  end
  
  private
  def get_country_new_poll
    @country = Country.find(params[:country_id]) if params[:country_id].present?
  end
  
  def set_return_to
    @poll = Poll.find(params[:id])
    
    @return_to = country_poll_path(@country, @poll)
  end
end


