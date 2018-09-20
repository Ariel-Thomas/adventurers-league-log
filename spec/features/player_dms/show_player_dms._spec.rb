require 'rails_helper'

RSpec.feature 'Player Dms', type: :feature do
  before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user, scope: :user)
    @player_dm = FactoryBot.create(:player_dm, user: @user)
  end

  scenario 'Show a Players DM' do
    visit user_player_dms_path(@user)

    expect(page).to have_text(@player_dm.name)
    expect(page).to have_text(@player_dm.dci)
  end
end
