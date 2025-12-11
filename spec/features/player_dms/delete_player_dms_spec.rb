require 'rails_helper'

RSpec.feature 'Player Dms', type: :feature do
  before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user, scope: :user)
    @player_dm = FactoryBot.create(:player_dm, user: @user)
  end

  scenario 'Delete a Players DM' do
    @player_dm_count = PlayerDm.count
    visit user_player_dms_path(@user)

    accept_confirm 'Are you sure' do
      click_link 'Delete'
    end
    # find_link('Delete').trigger('click') # hack to fix previous line

    expect(page).to have_text("Successfully deleted " + @player_dm.name)

    expect(PlayerDm.count).to be(@player_dm_count - 1)

    visit user_player_dms_path(@user)

    expect(page).to_not have_text(@player_dm.name)
    expect(page).to_not have_text(@player_dm.dci)
  end
end
