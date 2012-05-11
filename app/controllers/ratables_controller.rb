class RatablesController < ApplicationController
  def show
    @ratable = Ratable.find(params[:id])
    
    render "ratables/#{@ratable.type}/show"
  end    
end
