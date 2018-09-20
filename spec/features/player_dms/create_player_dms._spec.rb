require 'rails_helper'

RSpec.feature 'Player Dms', type: :feature do
  before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user, scope: :user)
    @player_dm = FactoryBot.create(:player_dm, user: @user)
  end

  scenario 'Create a Players DM' do
    @player_dm_count = PlayerDm.count
    visit user_player_dms_path(@user)

    all('a', text: 'New DM').first.click


    within('#player-dm-main-form') do
      fill_in 'DM Name',            with: 'Some DM'
      fill_in 'DM DCI',             with: '66666666'
    end

    click_button 'Save'

    expect(PlayerDm.count).to have_text(@player_dm_count + 1)

    expect(page).to have_text('Some DM')
    expect(page).to have_text('66666666')
  end
end
