require 'rails_helper'

RSpec.feature 'Locations', type: :feature do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user, scope: :user)
    @location = FactoryGirl.create(:location, user: @user)
  end

  scenario 'Edit an existing DM' do
    visit user_locations_path(@user)

    click_link "Edit"

    within('#location-main-form') do
      fill_in 'Name',            with: 'Another Location'
    end

    click_button 'Save'

    expect(page).to have_text('Another Location')
  end
end
