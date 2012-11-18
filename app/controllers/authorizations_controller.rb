class AuthorizationsController < ApplicationController
  require 'UserInfo'
  
  before_filter :require_user, :only => [:destroy]
  
  def create
    #raise request.env["omniauth.auth"].to_yaml
    info = UserInfo.new(request.env['omniauth.auth']) #this is where you get all the data from your provider through omniauth
    
    @auth = Authorization.find_by_provider_and_uid(info.provider, info.uid)
    @user = User.find_by_email(info.email)
    
    if @auth.present? #Need to be the first, to avoid duplicate auth
      flash[:notice] = "Welcome back #{info.provider} user"
      UserSession.create(@auth.user, true) #Returning user with same auth. Login the user with his social account
      
    elsif current_user # this is 'connecting to' feature, not login
      flash[:notice] = "Successfully added #{info.provider} authentication."
      current_user.authorizations.create(:provider => info.provider, :uid => info.uid, :token => info.token) #Add an auth to existing user
  
      redirect_to user_path(current_user)
      return true
      
    elsif @user.present? #Email has already been signed up
      @user.authorizations.create(:provider => info.provider, :uid  => info.uid, :token => info.token) 
      
      flash[:notice] = "A #{info.provider} authentication has been added to your account."
      UserSession.create(@user, true)
    
    elsif info.email.blank? # Trying to login with Twitter
      flash[:alert] = "Dear Twitter user. Please sign up first then connect your account to Twitter.<br/> Sorry for your trouble(blame the birdy)."
      
      redirect_to login_path
      return true
      
    else # All other possibilities exhausted, let us create a new user
      user = User.create_with_omniauth(info, country_code_from_request)
      user.authorizations.create(:provider => info.provider, :uid  => info.uid, :token => info.token) 
      
      flash[:notice] = "Welcome #{info.provider} user. Your account has been created."
      UserSession.create(user, true) #Log the authorizing user in.
    end
    
    redirect_to root_url
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
