class VotingsController < ApplicationController
  before_filter :require_user
  
  def create
    @country = Country.find(params[:country_id])
    @poll = Poll.find(params[:poll_id])
    @voting = current_user.votings.build( 
                                          :poll => @poll,
                                          :country => @country,
                                          :vote => get_vote_value(params[:positive])
                                        )
    
    if @voting.save
      redirect_to country_poll_path(@country, @poll)
    end
    
  end

  def update
    voting = Voting.find(params[:id])
    voting.vote = get_vote_value(params[:positive])
    poll = voting.poll
    
    if voting.save
      redirect_to country_poll_path(poll.country, poll)
    end
  end
  
  
  private
  def get_vote_value(positive)
    if positive.blank?
      Voting::NEGATIVE_VOTE
    else
      Voting::POSITIVE_VOTE
    end
  end
end
