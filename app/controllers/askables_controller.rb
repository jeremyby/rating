class AskablesController < ApplicationController
  before_filter :get_country, :except => [:new, :create]
  before_filter :get_askable, :except => [:new, :create]
  before_filter :set_return_to, :only => [:follow, :unfollow]
  before_filter :require_user, :except => [:show, :original, :comments]

  def new
    @askable = Askable.new(:yes => I18n.t('ans_yes'), :no => I18n.t('ans_no'))
    @country = Country.find(params[:country_id]) if params[:country_id].present?
  end

  def create
    type = params[:askable].delete(:type)
    
    if %w(Poll Question).include?(type)
      @askable = type.constantize.new(params[:askable])
      
      @askable.user_id = current_user.id
      @askable.body.capitalize!
      @askable.yes.capitalize! unless @askable.yes.blank?
      @askable.no.capitalize! unless @askable.no.blank?
      
      @country = Country.find_by_code(@askable.country_code)
      
      if @askable.save
        flash[:notice] = t('notice.askable_created', country_name: @country.to_s)

        redirect_to country_askable_path(@country, @askable) and return false
      end
    else
      flash[:alert] = I18n.t('notice.askable_type_missing')
    end
    
    render :new
  end

  def edit
  end

  def update
    if @askable.should_update?(params[:askable])
      @askable.attributes = params[:askable]
      
      if @askable.valid?
        flag = @askable.auto_translated
        
        # Auto-translated askable gets improved by user, set flag
        @askable.auto_translated = false if flag.present? && flag.to_i > 0
        
        @askable.save!
        
        @askable.translate_on_update if flag.nil? # Askable is original, check if it needs auto translation
      else
        submit_error
      end
    end
  end

  def show
    if request.path != country_askable_path(@country, @askable)
      redirect_to country_askable_path(@country, @askable), status: :moved_permanently and return
    end
    
    @langs = @askable.translations.collect {|t| t.locale}
    @orig_lang = @langs.shift
    
    current_uid = current_user.present? ? current_user.id : 0
  
    @complex, @is_end = @askable.answer_complex(current_uid, params[:last_answerable])
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def original
    @translation = @askable.translations.first
    
    @lang = @translation.locale
  end
  
  def comments
    @comments = @askable.root_comments.order('created_at DESC').page params[:page]
  end
  
  def follow
    current_user.follow(@askable)
  end

  def unfollow
    current_user.unfollow(@askable)

    render 'askables/follow'
  end

  private
  def get_askable
    begin
      @askable = Askable.find(params[:id])
      
      raise 'not available for this country' if @askable.country_code != @country.code
    rescue
      page_404
    end
  end

  def set_return_to
    @return_to = country_askable_path(@country, @askable)
  end
end