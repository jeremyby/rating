class RatablesController < ApplicationController
  def show
    @ratable = Ratable.find(params[:id])
    
    render "ratables/#{@ratable.class}/show"
  end    
end
