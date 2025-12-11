require 'rails_helper'

RSpec.feature 'Location', type: :feature, js: true do
  before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user, scope: :user)
    @location = FactoryBot.create(:location, user: @user)
  end

  scenario 'Delete a Location' do
    @location_count = Location.count
    visit user_locations_path(@user)

    accept_confirm 'Are you sure' do
      click_link 'Delete'
    end

    #find_link('Delete').trigger('click') # hack to fix previous line

    expect(page).to have_text("Successfully deleted " + @location.name)
    expect(Location.count).to be(@location_count - 1)

    visit user_locations_path(@user)

    expect(page).to_not have_text(@location.name)
  end
end
