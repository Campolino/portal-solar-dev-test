class PowerGeneratorsController < ApplicationController
  def index
    @power_generators = PowerGenerator.all
  end

  def search
    @parameters = params[:q].downcase
    @power_generators = PowerGenerator.all.where('name ILIKE :search', search: "%#{@parameters}%").or(PowerGenerator.all.where('description ILIKE :search', search: "%#{@parameters}%"))
    if @power_generators.any?
      render :index
    else
      @power_generators = PowerGenerator.all
      flash.now[:alert] = 'Nenhum produto encontrado para essa busca'
      render :index
    end
  end  
end
