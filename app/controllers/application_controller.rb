class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_locale
  
  helper_method :current_user_session, :current_user
  
  private
    def set_locale
      I18n.locale = extract_locale_from_subdomain

      # I18n.locale = params[:locale] || ((lang = request.env['HTTP_ACCEPT_LANGUAGE']) && lang[/^[a-z]{2}/])
    end
    
    def extract_locale_from_subdomain
      parsed_locale = request.subdomains.first || 'en'
      I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale : 'en'
    end
  
    def country_code_from_request
      info = Geoip.country(request.env["REMOTE_ADDR"])
    
      if info.country_code > 0
        info.country_code2.downcase
      else
        # flash.now[:alert] = "We can't tell which country you are from, so United States it is."
        return 'us'
      end
    end
  
    def get_country
      begin
        id = params[:country_id] || params[:id]

        @country = Country.find(id)
      rescue ActiveRecord::RecordNotFound
        page_404
      end
    end
    
    def submit_error
      flash.now[:alert] = t('notice.submit_error')

      render 'layouts/notify'
    end
    
    def page_404
      render :text => 'Not Found', :status => '404'
    end
  
    def page_500
      render :text => 'Something went wrong', :status => '500'
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

    def redirect_back_or_default(default)
      return_to = session[:return_to]
      session[:return_to] = nil
      redirect_to(return_to || default)
    end
end