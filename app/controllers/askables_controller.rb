class AskablesController < ApplicationController
  before_filter :get_country, :except => [:new, :create]
  before_filter :get_askable, :except => [:new, :create]
  before_filter :set_return_to, :only => [:follow, :unfollow]
  before_filter :require_user, :except => [:show, :original]

  def new
    @askable = Askable.new(:yes => I18n.t('m_yes'), :no => I18n.t('m_no'))
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
        flash[:notice] = t('askable.create.notice', country_name: @country.to_s)
        
        
        #TODO: move translation to model::after_create
        
        # default language is English, therefore:
        # => if the country has not language setting, it speadks English,
        # => so when being asked in another language, the translation target is also English
        if @country.language.blank?
          @country.language = target = 'en'
        else
          target = @country.language.split(' ').first
        end
        
        # if the asked country does not speak the language being used asking,
        # and assuming asking language is the same as the current locale
        # then send the new askable to translation queue
        unless @country.language.include?(I18n.locale.to_s)
          Delayed::Job.enqueue TranslationJob.new(@askable, I18n.locale.to_s, target)
        end

        redirect_to country_askable_path(@country, @askable) and return false
      end
    else
      flash[:alert] = "Bad question type!"
    end
    
    render :new
  end

  def edit
  end

  def update
    respond_to do |format|
      if @askable.update_attributes(params[:askable])
        # format.html { redirect_to(@user, :notice => 'Your question was successfully updated.') }
        format.json { respond_with_bip(@askable) }
      else
        # format.html { render :action => "edit" }
        format.json { respond_with_bip(@askable) }
      end
    end
  end

  def show
    if request.path != country_askable_path(@country, @askable)
      redirect_to @askable, status: :moved_permanently
    end
    
    @langs = @askable.translations.collect {|t| t.locale}
    @orig_lang = @langs.shift
    @is_orig = (@orig_lang == @askable.translation.locale)
    
    current_uid = current_user.present? ? current_user.id : 0
    last_answerable = params[:last_answer]
    
    @complex, @is_end = @askable.answer_complex(current_uid, last_answerable)
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def original
    @translation = @askable.translations.first
    
    @lang = @translation.locale
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
