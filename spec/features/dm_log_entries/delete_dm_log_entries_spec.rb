require 'rails_helper'

RSpec.feature 'DM Log Entries', type: :feature do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user, scope: :user)
    @character = FactoryGirl.create(:character, user: @user)
    @dm_log_entry = FactoryGirl.create(:dm_log_entry, user: @user)
    @dm_log_entry.characters = [@character]
  end

  scenario 'Delete a DM Log Entry' do
    @dm_log_entry_count = DmLogEntry.count
    visit user_dm_log_entries_path(@user)

    click_link 'Delete'
    # find_link('Delete').trigger('click') # hack to fix previous line

    expect(DmLogEntry.count).to be(@dm_log_entry_count - 1)

    expect(page).to_not have_text(@dm_log_entry.date_dmed.strftime('%Y-%m-%d %H:%M'))
    expect(page).to_not have_text(@dm_log_entry.adventure_title)
    expect(page).to_not have_text(@dm_log_entry.session_num)
    expect(page).to_not have_text(@dm_log_entry.xp_gained)
    expect(page).to_not have_text(@dm_log_entry.gp_gained.floor)
    expect(page).to_not have_text(@dm_log_entry.downtime_gained)
    expect(page).to_not have_text(@dm_log_entry.character.name)
  end
end
