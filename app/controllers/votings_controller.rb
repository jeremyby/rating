class VotingsController < ApplicationController
  before_filter :require_user

  def create
    begin
      @country = Country.find(params[:country_id])
      @poll = Poll.find(params[:poll_id])

      @voting = current_user.votings.create!(
        :poll_id => @poll.id,
        :country_code => @country.code,
        :vote => params[:voting][:vote].to_i,
        :explain => params[:voting][:explain]
      )

    rescue
      flash.now[:alert] = 'Your vote is not successful. Please check the info and try again.'

      render 'layouts/notify'
    end
  end

  def update
    begin
      @voting = Voting.find(params[:id])
      @voting.update_attributes!(:vote => params[:voting][:vote], :explain => params[:voting][:explain])

      @poll = @voting.poll
      @country = @voting.country
    rescue
      flash.now[:alert] = 'Vote Update is not successful. Please check the info and try again.'

      render 'layouts/notify'
    end
  end

  private
  def get_vote_value(positive)
    if positive.blank?
      Voting::YES_VOTE
    else
      Voting::NO_VOTE
    end
  end
end
