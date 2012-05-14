class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    
    if @user.save
      flash[:notice] = "Sign up successful!"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
