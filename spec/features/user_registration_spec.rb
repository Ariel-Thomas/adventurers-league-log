require 'rails_helper'

RSpec.feature 'User', type: :feature do
  scenario 'Create a new user' do
    visit root_path

    click_link 'Sign Up'

    fill_in 'Email', with: 'Test.User@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button 'Sign up'

    expect(page).to have_text('Welcome! You have signed up successfully.')
    expect(current_path).to eq(user_characters_path(User.first))
  end

  scenario 'Sign out as user' do
    user = FactoryGirl.create(:user)
    login_as(user, scope: :user)

    visit root_path

    click_link 'Log Out'

    expect(page).to have_text('Signed out successfully.')
    expect(current_path).to eq(root_path)
  end

  scenario 'Sign in as existing user' do
    user = FactoryGirl.create(:user)

    visit root_path
    click_link 'Log In', match: :first

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'

    click_button 'Log in'

    click_link 'Log Out'

    expect(page).to have_text('Signed out successfully.')
    expect(current_path).to eq(root_path)
  end
end
