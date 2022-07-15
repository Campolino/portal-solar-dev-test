require 'rails_helper'

context 'Usuário busca por geradores' do
  describe 'de forma simples' do
    it 'e visualiza geradores que possuem a caracteristica digitada' do
      visit '/'
      within '.simple-form' do
        fill_in 'q',	with: 'trifásico' 
        click_on 'Pesquisar'

      end

      expect('page').not_to have_content 'MONOFÁSICO'
    end
  end
end
