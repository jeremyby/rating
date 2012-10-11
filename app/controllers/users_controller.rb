class UsersController < ApplicationController
  def new
    @user = User.new

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
