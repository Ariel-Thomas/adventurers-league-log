require 'rails_helper'

RSpec.feature 'Locations', type: :feature do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user, scope: :user)
    @location = FactoryGirl.create(:location, user: @user)
  end

  scenario 'Create a Location' do
    @location_count = Location.count
    visit user_locations_path(@user)

    all('a', text: 'New Location').first.click


    within('#location-main-form') do
      fill_in 'Location',            with: 'Some Location'
    end

    click_button 'Save'

    expect(Location.count).to have_text(@location_count + 1)

    expect(page).to have_text('Some Location')
  end
end
