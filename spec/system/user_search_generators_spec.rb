require 'rails_helper'

context 'Usuário busca por geradores' do
  describe 'de forma simples' do
    it 'e visualiza geradores que possuem a caracteristica digitada' do
      visit root_path
      within '.simple-form' do
        within '.simple-form__input' do
          fill_in 'q',	with: 'trifásico'
        end 
        click_on 'Pesquisar'
      end

      expect(page).to have_content 'TRIFÁSICO 380V'
      expect(page).not_to have_content 'YC600 MONOFÁSICO'
      expect(page).not_to have_content 'Nenhum produto encontrado para essa busca'
    end

    it 'e busca não bate com nenhum gerador' do
      visit root_path
      within '.simple-form' do
        within '.simple-form__input' do
          fill_in 'q',	with: 'casa' 
        end
        click_on 'Pesquisar'
      end

      expect(page).to have_content 'Nenhum produto encontrado para essa busca'
      expect(page).to have_content 'YC600 MONOFÁSICO'
    end
  end
end
