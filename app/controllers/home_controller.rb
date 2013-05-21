class HomeController < ApplicationController
  def index
    if current_user
      @country = current_user.country

      countries = [@country.code]
      countries.concat(current_user.watching_countries.map(&:code))

      askables = current_user.following_askables.map(&:id)
      
      @entries = EntryLog.where('country_code in (?) or askable_id in (?)', countries, askables).order('created_at DESC')
      
      render 'users/home'
    else
      @country = Country.find_by_code(country_code_from_request)
      
      shuffle_poll
    end
  end
  
  def about
    
  end
  
  def shuffle
    shuffle_poll
    
    respond_to do |format|
      format.js
    end
  end
  
  def search
    @countries = Country.all
    
    respond_to do |format|
      format.js
    end
  end
  
  private
  def shuffle_poll
    cond = '1 = 1'
    cond.concat(' and id NOT in (?)') unless session[:shuffled_polls].blank?
    
    pool = Poll.featured.where(cond, session[:shuffled_polls])
    
    if pool.blank?
      session[:shuffled_polls] = nil
      
      @poll = Poll.featured.sample
    else
      @poll = pool.sample
    end
    
    session[:shuffled_polls] ||= Array.new
    session[:shuffled_polls] << @poll.id
  end  
end
