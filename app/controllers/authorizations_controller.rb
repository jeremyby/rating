class AuthorizationsController < ApplicationController
  require 'UserInfo'
  
  before_filter :require_user, :only => [:destroy]
  
  def create
    #raise request.env["omniauth.auth"].to_yaml
    info = UserInfo.new(request.env['omniauth.auth']) #this is where you get all the data from your provider through omniauth
    
    @auth = Authorization.find_by_provider_and_uid(info.provider, info.uid)
    @user = User.find_by_email(info.email)
    
    provider = info.provider.capitalize
    
    if @auth.present? #Need to be the first, to avoid duplicate auth
      flash[:notice] = "Welcome back #{provider} user"
      UserSession.create(@auth.user, true) #Returning user with same auth. Login the user with his social account
      
    elsif current_user # this is 'connecting to' feature, not login
      flash[:notice] = "Successfully added #{provider} authentication."
      current_user.authorizations.create(:provider => info.provider, :uid => info.uid, :token => info.token, :link => info.link) #Add an auth to existing user
  
      redirect_to user_path(current_user) and return true
      
    elsif @user.present? # A user has already signed up with that email
      @user.authorizations.create(:provider => info.provider, :uid  => info.uid, :token => info.token, :link => info.link) 
      
      flash[:notice] = "A #{provider} authentication has been added to your account."
      UserSession.create(@user, true)
    
    else
      flash[:notice] = "Welcome! #{info.name[0]} from #{provider}."
      session[:info] = info.select {|k, v| %(name email provider uid, token, link).include?(k) }
            
      # redirect to user#new, will render new_auth because session[:info]
      redirect_to signup_path and return true
    end
    
    redirect_back_or_default root_url
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
