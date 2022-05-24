# frozen_string_literal: true

require 'rails_helper'

describe 'Creating a user' do
  before :each do
    visit '/register'

    @phil = User.create!(name: 'Philly Steak', email: 'philly.steak@gmail.com', password: 'philly', password_confirmation: 'philly')
  end

  context 'when valid data is entered' do
    it 'creates a user' do
      fill_in :name, with: 'Billy Jonson'
      fill_in :email, with: 'billy.jonson@gmail.com'
      fill_in :password, with: 'skibbitybop'
      fill_in :password_confirmation, with: 'skibbitybop'
      click_button 'Register'

      user = User.last
      expect(current_path).to eq('/dashboard')
    end
  end

  context 'when invalid data is entered' do
    it 'email must be unique' do
      fill_in :name, with: 'Phil'
      fill_in :email, with: 'philly.steak@gmail.com'
      fill_in :password, with: 'philly'
      fill_in :password_confirmation, with: 'philly'
      click_button 'Register'

      expect(page).to have_content('Notice: Email has already been taken')
      expect(page).to have_content('Register a new User')
    end

    it 'email can not be blank' do
      fill_in :name, with: 'Phil'
      fill_in :password, with: 'phil'
      fill_in :password_confirmation, with: 'phil'
      click_button 'Register'

      expect(page).to have_content("Notice: Email can't be blank")
      expect(page).to have_content('Register a new User')
    end

    it 'name can not be blank' do
      fill_in :email, with: 'philly.phil@gmail.com'
      fill_in :password, with: 'philly'
      fill_in :password_confirmation, with: 'philly'
      click_button 'Register'

      expect(page).to have_content("Notice: Name can't be blank")
      expect(page).to have_content("Register a new User")
    end

    it 'password can not be blank' do
      fill_in :name, with: 'Phil'
      fill_in :email, with: 'philly.steak@gmail.com'
      fill_in :password_confirmation, with: 'phil'
      click_button 'Register'

      expect(page).to have_content("Notice: Password can't be blank")
      expect(page).to have_content("Register a new User")
    end

    it 'password confirmation can not be blank' do
      fill_in :name, with: 'Phil'
      fill_in :email, with: 'philly.steak@gmail.com'
      fill_in :password, with: 'phil'
      click_button 'Register'

      expect(page).to have_content("Notice: Password confirmation doesn't match Password")
      expect(page).to have_content("Register a new User")
    end

    it 'passwords must match' do
      fill_in :name, with: 'Phil'
      fill_in :email, with: 'philly.steak@gmail.com'
      fill_in :password, with: 'philly'
      fill_in :password_confirmation, with: 'phily'
      click_button 'Register'

      expect(page).to have_content("Notice: Password confirmation doesn't match Password")
      expect(page).to have_content('Register a new User')
    end
  end
end
