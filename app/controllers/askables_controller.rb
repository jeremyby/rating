class AskablesController < ApplicationController
  before_filter :get_country, :except => [:new, :create]
  before_filter :get_askable, :except => [:new, :create]
  before_filter :set_return_to, :only => [:follow, :unfollow]
  before_filter :require_user, :except => :show

  def new
    @askable = Askable.new
    @country = Country.find(params[:country_id]) if params[:country_id].present?
  end

  def create
    @askable = current_user.askables.build(params[:askable])
    @country = Country.find_by_code(@askable.country_code)

    if @askable.save
      flash[:notice] = "New question is added for #{ @country }."

      redirect_to country_askable_path(@country, @askable)
    else
      render :new
    end
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
    current_uid = current_user.present? ? current_user.id : 0
    last_answerable = params[:last_answer]
    
    @complex, @is_end = @askable.answer_complex(current_uid, last_answerable)
    
    respond_to do |format|
      format.html { render @askable.type.downcase }
      format.js { render @askable.type.downcase }
    end
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
