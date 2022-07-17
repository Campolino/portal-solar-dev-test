class PowerGeneratorsController < ApplicationController
  def index
    @power_generators = PowerGenerator.all
  end

  def search
    @parameters = params[:q].downcase
    @local = params[:local].to_i
    case @local
      when 2
        puts "Passou 2"
        @power_generators = PowerGenerator.all.where('kwp < :search', search: 3.0)
      when 3
        puts "Passou 3"
        @power_generators = PowerGenerator.all.where('kwp < :search', search: 20.0)
      when 4
        puts "Passou 4"
        @power_generators = PowerGenerator.all.where('kwp >= :search', search: 20.0)
      else
        puts "Passou tudo"
        @power_generators = PowerGenerator.all.where('name ILIKE :search', search: "%#{@parameters}%").or(PowerGenerator.all.where('description ILIKE :search', search: "%#{@parameters}%")).or(PowerGenerator.all.where('manufacturer ILIKE :search', search: "%#{@parameters}%"))
    end
    if @power_generators.any?
      render :index
    else
      redirect_to root_path, alert: 'Nenhum produto encontrado para essa busca'
    end
  end  
end
