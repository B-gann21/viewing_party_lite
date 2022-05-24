# frozen_string_literal: true

require 'rails_helper'

describe 'Discover Movies' do
  before do
    @user1 = User.create!(name: 'John', email: 'john.hennerich@gmail.com', password: 'john', password_confirmation: 'john')
    @user2 = User.create!(name: 'Brylan', email: 'brylan.gannon112@gmail.com', password: 'brylan', password_confirmation: 'brylan')

    visit '/'
    click_on 'Login'
    fill_in :email, with: @user1.email
    fill_in :password, with: @user1.password
    click_button 'Login'

    visit user_discover_index_path(@user1)
  end

  it 'Displays a header' do
    expect(page).to have_content('Discover Movies')
  end

  it 'displays a top movies button that routes to the discover page' do
    click_button 'Top Rated Movies'

    expect(current_path).to eq("/users/#{@user1.id}/movies")
  end

  it 'displays a search bar to find movies by keyword' do
    fill_in :query, with: 'Mad'
    click_button 'Search by Title'

    expect(current_path).to eq("/users/#{@user1.id}/movies")
  end
end
