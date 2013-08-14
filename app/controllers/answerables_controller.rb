class AnswerablesController < ApplicationController
  before_filter :require_user

  def create
    begin
      @country = Country.find_by_code(params[:answerable][:country_code])
      @askable = Askable.find(params[:answerable][:askable_id])
      
      @answerable = @askable.build_answerable(current_user, params[:answerable])
      
      @answerable.save!
      
      render 'update', locals: { create: true }
    rescue
      submit_error
    end
  end

  def update
    begin
      @answerable = Answerable.find(params[:id])
      body_updated = (params[:answerable][:body] != @answerable.body)
      
      @answerable.update_from(params[:answerable])
      
      @answerable.translate_on_update if @answerable.auto_translated.nil? && @answerable.body.present? && body_updated
      
      @askable = @answerable.askable
      @country = @answerable.country
    rescue
      submit_error
    end
  end
  
  def comments
    @answerable = Answerable.find(params[:id])
    @comments = @answerable.root_comments.order('created_at DESC').page params[:page]
  end
end
