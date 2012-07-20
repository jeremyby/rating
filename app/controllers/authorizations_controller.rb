class AuthorizationsController < ApplicationController
  require 'UserInfo'
  
  before_filter :require_user, :only => [:destroy]
  
  def create
    #raise request.env["omniauth.auth"].to_yaml
    info = UserInfo.new(request.env['omniauth.auth']) #this is where you get all the data from your provider through omniauth
    # provider, uid = omniauth['provider'].capitalize, omniauth['uid']
    
    @auth = Authorization.find_by_provider_and_uid(info.provider, info.uid)
        
    if current_user
      flash[:notice] = "Successfully added #{info.provider} authentication"
      current_user.authorizations.create(:provider => info.provider, :uid => info.uid) #Add an auth to existing user
    elsif @auth
      flash[:notice] = "Welcome back #{info.provider} user"
      UserSession.create(@auth.user, true) #User is present. Login the user with his social account
    else
      user = User.create_with_omniauth(info, geocode_from_request) #Create a new user
      @new_auth = user.authorizations.create(:provider => info.provider, :uid  => info.uid) 
      flash[:notice] = "Welcome #{info.provider} user. Your account has been created."
      UserSession.create(user, true) #Log the authorizing user in.
    end
    
    redirect_to '/'
  end

  def failure
    flash[:notice] = "Sorry, You did not authorize"
    redirect_back_or_default root_url
  end

  def blank
    render :text => "Not Found", :status => 404
  end

  def destroy
  end
end
