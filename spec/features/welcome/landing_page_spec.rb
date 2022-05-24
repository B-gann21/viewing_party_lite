# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'The landing page' do
  before :each do
    @fred = User.create!(name: 'Fred Jonson', email: 'fred.jonson@gmail.com', password: 'fred', password_confirmation: 'fred')
    @billy = User.create!(name: 'Billy Jones', email: 'billy.jones@gmail.com', password: 'billy', password_confirmation: 'billy')
    @sammy = User.create!(name: 'Sammy Jones', email: 'sammy.jones@gmail.com', password: 'sammy', password_confirmation: 'sammy')

    visit '/'
    click_on 'Login'
    fill_in :email, with: @fred.email
    fill_in :password, with: @fred.password
    click_button 'Login'

    visit '/'
  end

  it 'has the name of the app' do
    expect(page).to have_content('Viewing Party Lite')
  end

  it 'has a link to register a new user' do
    click_button 'New User'

    expect(current_path).to eq('/register')
    expect(page).to have_content('Register a new User')
  end

  it 'has a list of all existing users' do
    expect(page).to have_content('Billy Jones: billy.jones@gmail.com')
    expect(page).to have_content('Sammy Jones: sammy.jones@gmail.com')
    expect(page).to have_content('Fred Jonson: fred.jonson@gmail.com')
  end

  it 'has a link to the landing page' do
    click_link 'Landing Page'

    expect(current_path).to eq('/')
  end
end
