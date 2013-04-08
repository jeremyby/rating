class HomeController < ApplicationController
  def index
    if current_user
      @country = current_user.country

      countries = [@country.code]
      countries.concat(current_user.watching_countries.collect {|c| c.code})

      polls = current_user.following_polls.collect {|p| p.code}
      
      @entries = EntryLog.where('country_code in (?) or poll_id in (?)', countries, polls).order('created_at DESC')
      
      render 'users/home'
    else
      @country = Country.find_by_code(country_code_from_request)
      
      shuffle_a_poll
            
      unless Available_Countries.include?(@country.code)
        flash.now[:notice] = "Are you from #{@country}? Our service for your country is limited for now. <a href='/help#limited_service'>why?</a>"
      end
    end
  end
  
  def about
    
  end
  
  def shuffle
    shuffle_a_poll
    
    respond_to do |format|
      format.js
    end
  end
  
  def search
    @countries = Country.available
    @countries.concat(Country.unavailable)
    
    respond_to do |format|
      format.js
    end
  end
  
  private
  def shuffle_a_poll
    cond = '1 == 1'
    cond.concat(' and id NOT in (?)') unless session[:shuffled_polls].blank?
    
    pool = Poll.featured.where(cond, session[:shuffled_polls])
    
    if pool.blank?
      session[:shuffled_polls] = nil
      
      @poll = Poll.featured.sample
    else
      @poll = pool.sample
    end
    
    store_poll_shuffle(@poll)
  end  
end
