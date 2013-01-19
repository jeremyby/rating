class UsersController < ApplicationController
  require 'UserInfo'
  
  can_edit_on_the_spot
  
  def new
    @info = session[:info]
    session[:info] = nil
    
    if @info.present?
      @user = User.build_from_info(@info, country_code_from_request)
      
      render 'new_auth'
    else
      @user = User.new
      
      render 'new'
    end
  end

  def create
    @user = User.new
    @user.assign_attributes(params[:user], :as => :default)
    @user.country_code = country_code_from_request
    
    if @user.save
      flash[:notice] = "Sign up successful!"
      redirect_to root_url
    else
      render :new
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.assign_attributes(params[:user], :as => :default)

    
    if @user.save
      flash[:notice] = "Successfully updated profile."
      redirect_to :action => "show"
    else
      render :action => "show"
    end
  end

  def destroy
  end
end
