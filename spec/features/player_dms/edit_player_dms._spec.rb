require 'rails_helper'

RSpec.feature 'Player Dms', type: :feature do
  before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user, scope: :user)
    @player_dm = FactoryBot.create(:player_dm, user: @user)
  end

  scenario 'Edit an existing DM' do
    visit user_player_dms_path(@user)

    click_link "Edit"

    within('#player-dm-main-form') do
      fill_in 'DM Name',            with: 'Another Person'
      fill_in 'DM DCI',             with: '44444444'
    end

    click_button 'Save'

    expect(page).to have_text('Another Person')
    expect(page).to have_text('44444444')
  end
end
