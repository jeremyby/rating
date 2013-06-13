class AnswerablesController < ApplicationController
  before_filter :require_user

  def create
    begin
      @country = Country.find_by_code(params[:answerable][:country_code])
      @askable = Askable.find(params[:answerable][:askable_id])
      
      @answerable = @askable.build_answerable(current_user, params[:answerable])
      @answerable.save!
    rescue
      flash.now[:alert] = 'Your vote is not successful. Please check the info and try again.'
    
      render 'layouts/notify'
    end
  end

  def update
    begin
      @ballot = Ballot.find(params[:id])
      orig_answer = @ballot.body

      @ballot.update_attributes!(:vote => params[:answerable][:vote], :body => params[:answerable][:body])
      
      event = Event.find_by_answerable_id(@ballot.id)
      event.delete if event.present?
      
      @ballot.reload.log_event

      @askable = @ballot.askable
      @country = @ballot.country
    rescue
      flash.now[:alert] = 'Your submit is not successful. Please check the info and try again.'
    
      render 'layouts/notify'
    end
  end
end
