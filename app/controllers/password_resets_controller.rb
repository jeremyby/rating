class PasswordResetsController < ApplicationController
  before_filter :require_no_user
  before_filter :load_user_using_perishable_token, :only => [:show, :update]

  def create
    @user = User.find_by_email(params[:email])
    
    unless @user.blank?
      @user.deliver_password_reset_instructions!
      redirect_to root_url, :notice => "Email sent with password reset link."
    else
      flash[:notice] = "No user was found with that email address"
      render :index
    end
  end

  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    
    if @user.save
      flash[:notice] = "Password has been reset."
      redirect_to root_url
    else
      render :show
    end
  end

  private
  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])

    if @user.blank?
      flash[:notice] = "The password reset code is invalid or it has expired. Please try again."
      redirect_to password_resets_path
    end
  end
end
