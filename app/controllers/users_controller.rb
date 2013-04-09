class UsersController < ApplicationController
  # require 'UserInfo'

  def new
    @info = session[:info]

    if @info.present?
      @user = User.build_from_info(@info, country_code_from_request)

      render :new_auth
    else
      @user = User.new

      render :new
    end
  end

  def create
    @info = session[:info]
    session[:info] = nil

    @user = User.new(params[:user])
    @user.country_code = country_code_from_request


    #TODO: test below block
    if @user.save
      @user.authorizations.create!(
        :provider => info.provider,
        :uid  => info.uid,
        :token => info.token,
        :link => info.link
      ) if @info.present?

      flash[:notice] = "Sign up successful!"
      redirect_to root_url
    else
      render (@info.blank? ? :new : :new_auth)
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])

    if @user.save
      flash[:notice] = "Successfully updated profile."
      redirect_to :action => "show"
    else
      render :show
    end
  end

  def destroy
  end
end
