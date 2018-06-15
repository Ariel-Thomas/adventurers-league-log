require 'rails_helper'

RSpec.feature 'Location', type: :feature do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user, scope: :user)
    @location = FactoryGirl.create(:location, user: @user)
  end

  scenario 'Delete a Location' do
    @location_count = Location.count
    visit user_locations_path(@user)

    click_link 'Delete'
    # find_link('Delete').trigger('click') # hack to fix previous line

    expect(Location.count).to be(@location_count - 1)

    expect(page).to have_text("Successfully deleted " + @location.name)

    visit user_locations_path(@user)

    expect(page).to_not have_text(@location.name)
  end
end
