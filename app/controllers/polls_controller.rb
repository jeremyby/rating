class PollsController < ApplicationController
  before_filter :get_country, :except => [:new, :create]
  before_filter :get_poll, :except => [:new, :create]
  before_filter :set_return_to, :only => [:follow, :unfollow]
  before_filter :require_user, :except => :show

  def new
    @poll = Poll.new
    @country = Country.find(params[:country_id]) if params[:country_id].present?
  end

  def create
    @poll = current_user.polls.build(params[:poll])
    @country = Country.find_by_code(@poll.country_code)

    if @poll.save
      flash[:notice] = "New question is added for #{ @country }."

      redirect_to country_poll_path(@country, @poll)
    else
      render :new
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @poll.update_attributes(params[:poll])
        # format.html { redirect_to(@user, :notice => 'Your question was successfully updated.') }
        format.json { respond_with_bip(@poll) }
      else
        # format.html { render :action => "edit" }
        format.json { respond_with_bip(@poll) }
      end
    end
  end

  def destroy
  end

  def show
    current_user_id = current_user.present? ? current_user.id : 0
    last_ballot_id = params[:last_ballot]

    @complex, @no_more = @poll.ballot_complex(current_user_id, last_ballot_id) if @poll.ballots_count.present? && @poll.ballots_count > 10

    respond_to do |format|
      format.html
      format.js
    end
  end

  def follow
    current_user.follow(@poll)
  end

  def unfollow
    current_user.unfollow(@poll)

    render 'polls/follow'
  end

  private
  def get_poll
    begin
      @poll = Poll.find(params[:id])
      raise 'not a poll for this country' if @poll.country_code != @country.code
    rescue
      page_404 and return false
    end
  end

  def set_return_to
    @return_to = country_poll_path(@country, @poll)
  end
end
