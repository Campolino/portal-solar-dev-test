class PowerGeneratorsController < ApplicationController
  def index
    @power_generators = PowerGenerator.all
  end

  def search
    @parameters = params[:q].downcase
    @power_generators = PowerGenerator.all.where('name ILIKE :search', search: "%#{@parameters}%")
    render 'index'
  end  
end
