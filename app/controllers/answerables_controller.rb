class AnswerablesController < ApplicationController
  before_filter :require_user

  def create
    # begin
      @country = Country.find_by_code(params[:answerable][:country_code])
      @askable = Askable.find(params[:answerable][:askable_id])
      
      @answerable = @askable.build_answerable(current_user, params[:answerable])
      
      @answerable.save!
    # rescue
    #   flash.now[:alert] = 'Your vote was not successful. Please check and try again.'
    # 
    #   render 'layouts/notify'
    # end
  end

  def update
    begin
      @answerable = Ballot.find(params[:id])
      @answerable.update_attributes!(:vote => params[:answerable][:vote], :body => params[:answerable][:body])
      
      event = Event.find_by_answerable_id(@answerable.id)
      event.delete if event.present?
      
      @answerable.reload.log_event

      @askable = @answerable.askable
      @country = @answerable.country
    rescue
      flash.now[:alert] = 'Your submit is not successful. Please check and try again.'
    
      render 'layouts/notify'
    end
  end
end
