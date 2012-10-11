class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user_session, :current_user
  
  protected
  def country_code_from_request
    info = $geoip.country(request.env["REMOTE_ADDR"])
    
    if info.country_code > 0
      info.country_code2.downcase
    else
      "cn"
    end
  end
  
  def get_country
    begin
      @country = Country.find(params[:country_id])
    rescue ActiveRecord::RecordNotFound
      page_404
    end
  end
  
  def require_user(pass_return_url = false)
    logger.debug "ApplicationController::require_user"
    unless current_user
      store_location unless pass_return_url
      flash[:alert] = "You must be logged in to access this page"
      redirect_to "/login"
      return false
    end
  end
  
  def page_404
    redirect_to "/404.html"
  end
  
  def page_500
    redirect_to "/500.html"
  end
  
  private
    def current_user_session
      logger.debug "ApplicationController::current_user_session"
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      logger.debug "ApplicationController::current_user"
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end

    def require_no_user
      logger.debug "ApplicationController::require_no_user"
      if current_user
        store_location
        flash[:alert] = "You must be logged out to access this page"
        redirect_to account_url
        return false
      end
    end

    def store_location
      session[:return_to] = request.url
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
end
