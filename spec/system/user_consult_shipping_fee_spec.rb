require 'rails_helper'

context 'Usuário acessa a página de qualquer gerador' do
  describe 'e consulta o valor do frete para o seu CEP' do
    it 'com sucesso' do
      response = Faraday.get('https://viacep.com.br/ws/00000000/json/')
      JSONresponse = JSON.parse(response.body)
      state = JSONresponse['uf']
      
      visit '/'
      click_on 'TRIFÁSICO 380V', :match => :first
      fill_in 'cep', with: '89287395'
      click_on 'Consultar'

      expect(page).to have_content 'Frete para: Rua Francisco Dreschler - CEP: 89287-395'
    end
  end
end