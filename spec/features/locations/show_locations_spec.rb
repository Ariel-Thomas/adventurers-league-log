require 'rails_helper'

RSpec.feature 'Locations', type: :feature do
  before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user, scope: :user)
    @location = FactoryBot.create(:location, user: @user)
  end

  scenario 'Show a Location' do
    visit user_locations_path(@user)

    expect(page).to have_text(@location.name)
  end
end
