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

    visit user_dm_log_entries_path(@user)

    expect(page).to_not have_text(@dm_log_entry.date_dmed
                                               .strftime('%Y-%m-%d %H:%M'))
    expect(page).to_not have_text(@dm_log_entry.adventure_title)
    expect(page).to_not have_text(@dm_log_entry.session_num)
    expect(page).to_not have_text(@dm_log_entry.xp_gained)
    expect(page).to_not have_text(@dm_log_entry.gp_gained.floor)
    expect(page).to_not have_text(@dm_log_entry.downtime_gained)
    expect(page).to_not have_text(@dm_log_entry.character.name)

    expect(page).to have_text("DM Log Entries")
  end

  context 'via character page' do
    before(:each) do
      @dm_log_entry.characters = [@character]
      @dm_log_entry.save!
    end

    scenario 'Edit a DM Log Entry' do
      @dm_log_entry_count = DmLogEntry.count

      visit user_character_path(@user, @character)
      within(".list-buttons .hidden-xs") do
        click_link 'DM Logs'
      end

      click_link 'Delete'
      # find_link('Delete').trigger('click') # hack to fix previous line

      expect(DmLogEntry.count).to be(@dm_log_entry_count - 1)

      expect(page).to_not have_text("DM Log Entries")

      visit user_dm_log_entries_path(@user)

      expect(page).to_not have_text(@dm_log_entry.date_dmed
                                                 .strftime('%Y-%m-%d %H:%M'))
      expect(page).to_not have_text(@dm_log_entry.adventure_title)
      expect(page).to_not have_text(@dm_log_entry.session_num)
      expect(page).to_not have_text(@dm_log_entry.xp_gained)
      expect(page).to_not have_text(@dm_log_entry.gp_gained.floor)
      expect(page).to_not have_text(@dm_log_entry.downtime_gained)
      expect(page).to_not have_text(@dm_log_entry.character.name)
    end

  end
end
