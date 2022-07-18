class PowerGeneratorsController < ApplicationController
  def index
    @power_generators = PowerGenerator.all.page params[:page]
    unless params[:order].nil?
      @power_generators = PowerGenerator.all.order(kwp: :desc).page params[:page] if params[:order] == 'kwp'
      @power_generators = PowerGenerator.all.order(price: :asc).page params[:page] if params[:order] == 'price'
    end
  end

  def show
    @power_generator = PowerGenerator.find_by_id(params[:id])
  end

  def prices
    @power_generator = PowerGenerator.find_by_id(params[:id])
    @cep = params[:cep]
    unless @cep.nil?
      response = Faraday.get("https://viacep.com.br/ws/#{@cep}/json/")
      if response.body.include?('erro')
        flash.now['alert'] = 'CEP não encontrado'
      else
        json_response = JSON.parse(response.body)
        state =  json_response['uf']
        @logradouro = json_response['logradouro']
        @CEP = json_response['cep']
        @freights = Freight.where("state ILIKE :state AND weight_max < :pweight", state: "#{state}", pweight: "#{@power_generator.weight}").order(:cost)
      end
    end
    render :show
  end

  def search
    @parameters = params[:q].downcase
    @local = params[:local].to_i
    case @local
      when 2
        @power_generators = PowerGenerator.all.where('kwp < :search', search: 3.0).page params[:page]
      when 3
        @power_generators = PowerGenerator.all.where('kwp < :search', search: 20.0).page params[:page]
      when 4
        @power_generators = PowerGenerator.all.where('kwp >= :search', search: 20.0).page params[:page]
      else
        @power_generators = PowerGenerator.all.where('name ILIKE :search', search: "%#{@parameters}%").or(PowerGenerator.all.where('description ILIKE :search', search: "%#{@parameters}%")).or(PowerGenerator.all.where('manufacturer ILIKE :search', search: "%#{@parameters}%")).page params[:page]
    end
    if @power_generators.any?
      render :index
    else
      redirect_to root_path, alert: 'Nenhum produto encontrado para essa busca'
    end
  end
end
