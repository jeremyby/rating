class BallotsController < ApplicationController
  before_filter :require_user

  def create
    begin
      @country = Country.find(params[:country_id])
      @poll = Poll.find(params[:poll_id])

      @ballot = current_user.ballots.create!(
        :poll_id => @poll.id,
        :country_code => @country.code,
        :vote => params[:ballot][:vote].to_i,
        :answer => params[:ballot][:answer]
      )

    rescue
      flash.now[:alert] = 'Your vote is not successful. Please check the info and try again.'

      render 'layouts/notify'
    end
  end

  def update
    begin
      @ballot = Ballot.find(params[:id])
      orig_answer = @ballot.answer

      @ballot.update_attributes!(:vote => params[:ballot][:vote], :answer => params[:ballot][:answer])
      
      # log entry of the answer
      @ballot.entry_logs.create(
        :kind => 'answer',
        :country_code => @ballot.country_code,
        :poll_id => @ballot.poll_id,
        :user_id => @ballot.user_id
      ) if orig_answer.blank? && params[:ballot][:answer].present?

      @poll = @ballot.poll
      @country = @ballot.country
    rescue
      flash.now[:alert] = 'Your submit is not successful. Please check the info and try again.'
    
      render 'layouts/notify'
    end
  end

  private
  def get_vote_value(positive)
    if positive.blank?
      Ballot::YES_VOTE
    else
      Ballot::NO_VOTE
    end
  end
end
