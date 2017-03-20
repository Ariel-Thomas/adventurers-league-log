require 'rails_helper'

RSpec.feature 'DM Log Entries', type: :feature do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user, scope: :user)
    @character    = FactoryGirl.create(:character, user: @user)
    @dm_log_entry = FactoryGirl.create(:dm_log_entry, user: @user)
    @dm_log_entry.characters = [@character]
  end

  scenario 'DM Log Entry index page should have information' do
    visit user_dm_log_entries_path(@user)

    expect(page).to have_text(@dm_log_entry.date_dmed.strftime('%Y-%m-%d %H:%M'))
    expect(page).to have_text(@dm_log_entry.adventure_title)
    expect(page).to have_text(@dm_log_entry.session_num)
    expect(page).to have_text(@dm_log_entry.xp_gained)
    expect(page).to have_text(@dm_log_entry.gp_gained.floor)
    expect(page).to have_text(@dm_log_entry.downtime_gained)
    expect(page).to have_text(@dm_log_entry.character.name)
  end

  scenario 'DM Log Entry show page should have information' do
    visit user_dm_log_entry_path(@user, @dm_log_entry)

    expect(page).to have_text(@dm_log_entry.adventure_title)
    expect(page).to have_text(@dm_log_entry.session_num)
    expect(page).to have_text(@dm_log_entry.date_dmed.strftime('%Y-%m-%d %H:%M'))
    expect(page).to have_text(@dm_log_entry.xp_gained)
    expect(page).to have_text(@dm_log_entry.gp_gained.floor)
    expect(page).to have_text(@dm_log_entry.downtime_gained)
    expect(page).to have_text(@dm_log_entry.location_played)
    expect(page).to have_text(@dm_log_entry.notes)

    expect(page).to have_text(@dm_log_entry.date_played.strftime('%Y-%m-%d %H:%M'))
    expect(page).to have_text(@dm_log_entry.character.name)
  end

  context 'Many DM Log Entries' do
    before(:each) do
      @unassigned_log_entries = 20.times.map { FactoryGirl.create(:dm_log_entry, user: @user, character: nil) }
    end

    scenario 'DM Log Entry show page should have aggregate info' do
      visit user_dm_log_entries_path(@user)

      expect(page).to have_text(@unassigned_log_entries.map(&:xp_gained).compact.inject(:+).to_s)
      expect(page).to have_text(@unassigned_log_entries.map(&:xp_gained).compact.inject(:+) + @dm_log_entry.xp_gained)

      expect(page).to have_text(@unassigned_log_entries.map(&:gp_gained).compact.inject(:+).to_s)
      expect(page).to have_text(@unassigned_log_entries.map(&:gp_gained).compact.inject(:+) + @dm_log_entry.gp_gained)

      expect(page).to have_text(@unassigned_log_entries.map(&:downtime_gained).compact.inject(:+).to_s)
      expect(page).to have_text(@unassigned_log_entries.map(&:downtime_gained).compact.inject(:+) + @dm_log_entry.downtime_gained)

      expect(page).to have_text(@unassigned_log_entries.map(&:renown_gained).compact.inject(:+).to_s)
      expect(page).to have_text(@unassigned_log_entries.map(&:renown_gained).compact.inject(:+) + @dm_log_entry.renown_gained)
    end
  end
end
