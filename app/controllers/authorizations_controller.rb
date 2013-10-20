class AuthorizationsController < ApplicationController
  layout "callback"
  
  before_filter :require_user, :only => [:destroy]
  
  def create
    # raise request.inspect
    info = UserInfo.new(request.env['omniauth.auth']) # the data from the provider through omniauth
    
    @auth = Authorization.find_by_provider_and_uid(info.provider, info.uid)
    @user = User.find_by_email(info.email)
    @dest = root_url
    
    @provider = info.provider.capitalize
    
    if @auth.present? # Need to be the first, to avoid duplicate auth, equivalent to log in
      session[:auth_msg] = "Welcome back #{ @provider } user"
      UserSession.create(@auth.user, true) #Returning user with same auth. Login the user with the social account
      
    elsif current_user || @user.present? # this is either 'connecting to' feature, or user with matching email signing in with new auth.
      session[:auth_msg] = "New authorization by #{ @provider } is added."
      current_user.authorizations.create(:provider => info.provider, :uid => info.uid, :token => info.token, :link => info.link) #Add an auth to existing user
    
      if current_user # user was logged in, so this is 'connect to' - not implemented yet
        @dest = user_url(current_user)
      else # new auth
        UserSession.create(@user, true)
      end
    else
      session[:auth_msg] = "Welcome! #{info.name[0]} from #{ @provider }."
      session[:info] = info
            
      # redirect to user#new, will render new_auth because session[:info] exists
      @dest = signup_url
    end
  end
end
