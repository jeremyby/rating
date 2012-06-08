class RatablesController < ApplicationController
  def index
    type = params[:ratable_type].capitalize
    render "ratables/#{type}/index"
  end
  
  def show
    @ratable = Ratable.find(params[:id])
    
    render "ratables/#{@ratable.class}/show"
  end    
end
