class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user_session, :current_user
  
  private
    def country_code_from_request
      info = $geoip.country(request.env["REMOTE_ADDR"])
    
      if info.country_code > 0
        info.country_code2.downcase
      else
        # flash.now[:alert] = "We can't tell which country you are from, so United States it is."
        return 'us'
      end
    end
  
    def get_country
      begin
        # if no country_id param, empty @country will be evaluated, instead of 404
        @country = Country.find(params[:country_id]) if params[:country_id].present?
      rescue ActiveRecord::RecordNotFound
        page_404
      end
    end
  
    def page_404
      redirect_to "/404.html"
    end
  
    def page_500
      redirect_to "/500.html"
    end
  
    def current_user_session
      #logger.debug "ApplicationController::current_user_session"
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      #logger.debug "ApplicationController::current_user"
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end
    
    def require_user
      # logger.debug "ApplicationController::require_user"    
      unless current_user        
        if request.xhr?
          url = "/login"
          url.concat("?return_to=#{@return_to}") unless @return_to.blank?
          
          flash.now[:alert] = "Your account info is required. Please <a href='#{url}'>log in</a> first.".html_safe
          render 'layouts/notify'
        else
          store_location
          flash[:alert] = "Your account info is required. Please log in first."
          redirect_to login_path
        end
        
        return false
      end
    end
    
    def require_no_user
      logger.debug "ApplicationController::require_no_user"
      if current_user
        store_location
        flash[:alert] = "You must be logged out to access this page."
        redirect_to root_url
        return false
      end
    end

    def xhr_check
      unless request.xhr?
        page_404
      end
    end
    
    def store_location(addr=request.url)
      session[:return_to] = addr
    end
    
    def store_poll_shuffle(poll)
      session[:shuffled_polls] ||= Array.new
      session[:shuffled_polls] << poll.id
    end

    def redirect_back_or_default(default)
      return_to = session[:return_to]
      session[:return_to] = nil
      redirect_to(return_to || default)
    end
end