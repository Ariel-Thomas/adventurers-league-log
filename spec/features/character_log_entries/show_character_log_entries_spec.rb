require 'rails_helper'

RSpec.feature 'Character Log Entries', type: :feature do
  before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user, scope: :user)
    @character    = FactoryBot.create(:character, user: @user)
    @character_log_entry = FactoryBot.create(:character_log_entry, user: @user)
    @character_log_entry.characters = [@character]
  end

  scenario 'Character Log Entry index page should have information' do
    visit user_character_path(@user, @character)

    expect(page).to have_text(@character_log_entry.date_played.strftime('%Y-%m-%d %H:%M'))
    expect(page).to have_text(@character_log_entry.adventure_title)
    expect(page).to have_text(@character_log_entry.session_num)
    expect(page).to have_text(@character_log_entry.xp_gained)
    expect(page).to have_text(@character_log_entry.gp_gained.floor)
    expect(page).to have_text(@character_log_entry.downtime_gained)
  end

  scenario 'Character Log Entry show page should have information' do
    visit user_character_character_log_entry_path(@user, @character, @character_log_entry)

    expect(page).to have_text(@character_log_entry.adventure_title)
    expect(page).to have_text(@character_log_entry.session_num)
    expect(page).to have_text(@character_log_entry.date_played.strftime('%Y-%m-%d %H:%M'))
    expect(page).to have_text(@character_log_entry.xp_gained)
    expect(page).to have_text(@character_log_entry.gp_gained.floor)
    expect(page).to have_text(@character_log_entry.downtime_gained)
    expect(page).to have_text(@character_log_entry.location_played)
    expect(page).to have_text(@character_log_entry.notes)
  end
end
