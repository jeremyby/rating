class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
    @user_session.remember_me = true
    
    session[:return_to] = params[:return_to] if params[:return_to].present?
  end

  def create    
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Login successful!"
      redirect_back_or_default root_url
    else
      render :action => :new
    end    
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "You have logged out."
    redirect_back_or_default root_url
  end
end
