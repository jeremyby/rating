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
      
      
      el = EntryLog.find_by_answerable_id(@ballot.id)
      el.delete if el.present?
      
      if params[:answerable][:body].present?
        # log entry of the answer
        @ballot.entry_logs.create(
          :kind => 'Answer',
          :country_code => @ballot.country_code,
          :askable_id => @ballot.askable_id,
          :user_id => @ballot.user_id
        )
      end

      @askable = @ballot.askable
      @country = @ballot.country
    rescue
      flash.now[:alert] = 'Your submit is not successful. Please check the info and try again.'
    
      render 'layouts/notify'
    end
  end
end
