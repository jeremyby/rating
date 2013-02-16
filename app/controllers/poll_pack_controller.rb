class PollPackController < ApplicationController
  before_filter :require_user
  before_filter :get_country
  before_filter :xhr_check, :except => [:index]
  
  def index
    #TODO: remove this
    session[:poll_pack] = [15, 14, 13, 12, 11, 10, 9, 8, 7, 4]
    
    if session[:poll_pack].blank?
      flash[:alert] = "You were not supposed to go there by yourself. Let us try again, shall we?"
      redirect_to country_path(@country)
    end
      
    poll_pack = session[:poll_pack]
    
    @polls = Poll.includes(:ballots).where(:id => poll_pack).where("ballots.user_id = ?", current_user.id)
    
    session[:poll_pack] = nil
  end
  
  def new    
    @polls = current_user.get_poll_pack_for(@country.code)
    
    respond_to do |format|
      format.js
    end
  end
  
  def create
    ballots = params[:results]
    poll_pack = []
    
    ballots.each do |v|
      current_user.ballots.create!(:country_code => @country.code, :poll_id => v[1]["id"].to_i, :vote => v[1]["vote"].to_i)
      poll_pack << v[1]["id"].to_i
    end
    
    #TODO: add rescue block here
    session[:poll_pack] = poll_pack
    
    head :ok
  end
end
