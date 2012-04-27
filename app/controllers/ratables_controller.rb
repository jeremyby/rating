class RatablesController < ApplicationController
  def show
    @ratable = Ratable.find(params[:id])
    
  end    
end
