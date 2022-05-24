require 'rails_helper'

RSpec.describe 'The User login page' do
  before :each do
    @user = User.create!(name: 'Brylan', email: 'brylan.gannon@gmail.com', password: 'hingadurgen', password_confirmation: 'hingadurgen')

    visit '/login'
  end

  context 'when valid data is given' do
    it 'brings you to the user dashboard page' do
      fill_in :email, with: 'brylan.gannon@gmail.com'
      fill_in :password, with: 'hingadurgen'
      click_button 'Login'

      expect(current_path).to eq('/dashboard')
    end
  end

  context 'when invalid data is given' do
    it 'email is incorrect' do
      fill_in :email, with: '12454'
      fill_in :password, with: 'hingadurgen'
      click_button 'Login'


      expect(page).to have_content("User Login")
      expect(page).to have_content("Notice: invalid entry")
    end

    it 'password is incorrect' do
      fill_in :email, with: 'brylan.gannon@gmail.com'
      fill_in :password, with: 'higadurgen'
      click_button 'Login'

      expect(page).to have_content('User Login')
      expect(page).to have_content('Notice: invalid entry')
    end
  end
end
