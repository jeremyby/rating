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
      orig_body = @answerable.body
      
      @answerable.attributes = params[:answerable].delete_if {|k, v| k == 'country_code' || k == 'askable_id'}
      
      unless @answerable.auto_translated.nil? # improving a translation
        submit_error(t('errors.messages.remove_ballot_answer_translation')) and return false if @answerable.body.blank?
        
        @answerable.auto_translated = false
      end
        
      @answerable.save!
      
      if @answerable.auto_translated.nil? && @answerable.body != orig_body  && (orig_body.present? || @answerable.body.present?) # Original Answer and there is changes on body
        if @answerable.body.blank? # Ballot body is deleted, therefore log_update was not triggered
          array = @answerable.translations.drop(1)
        
          # if the translation is auto-translated, remove its body
          array.each { |t| t.update_attribute('body', '') if t.auto_translated == '1' }
        
          @answerable.events.first.destroy if array.reject {|t| t.body.blank? }.empty?
        else
          @answerable.translate_on_update
        end
      end
      
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
