require 'rails_helper'

RSpec.feature 'Campaign Log Entries', type: :feature do
  before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user, scope: :user)
    @character1    = FactoryBot.create(:character, publicly_visible: true)
    @character2    = FactoryBot.create(:character, publicly_visible: true)
    @campaign_log_entry = FactoryBot.create(:campaign_log_entry, user: @user)
    @campaign_log_entry.characters = [@character1, @character2]
  end

  scenario 'Campaign Log Entry index page should have information on both character pages' do
    visit user_character_path(@character1.user, @character1)

    expect(page).to have_text(@campaign_log_entry.date_played.strftime('%Y-%m-%d %H:%M'))
    expect(page).to have_text(@campaign_log_entry.adventure_title)
    expect(page).to have_text(@campaign_log_entry.session_num)
    expect(page).to have_text(@campaign_log_entry.xp_gained)
    expect(page).to have_text(@campaign_log_entry.gp_gained.floor)
    expect(page).to have_text(@campaign_log_entry.downtime_gained)

    visit user_character_path(@character2.user, @character2)

    expect(page).to have_text(@campaign_log_entry.date_played.strftime('%Y-%m-%d %H:%M'))
    expect(page).to have_text(@campaign_log_entry.adventure_title)
    expect(page).to have_text(@campaign_log_entry.session_num)
    expect(page).to have_text(@campaign_log_entry.xp_gained)
    expect(page).to have_text(@campaign_log_entry.gp_gained.floor)
    expect(page).to have_text(@campaign_log_entry.downtime_gained)
  end

  scenario 'Campaign Log Entry show page should have information for both characters' do
    visit user_character_campaign_log_entry_path(@character1.user, @character1, @campaign_log_entry)

    expect(page).to have_text(@campaign_log_entry.adventure_title)
    expect(page).to have_text(@campaign_log_entry.session_num)
    expect(page).to have_text(@campaign_log_entry.date_played.strftime('%Y-%m-%d %H:%M'))
    expect(page).to have_text(@campaign_log_entry.xp_gained)
    expect(page).to have_text(@campaign_log_entry.gp_gained.floor)
    expect(page).to have_text(@campaign_log_entry.downtime_gained)
    expect(page).to have_text(@campaign_log_entry.location_played)
    expect(page).to have_text(@campaign_log_entry.notes)

    visit user_character_campaign_log_entry_path(@character2.user, @character2, @campaign_log_entry)

    expect(page).to have_text(@campaign_log_entry.adventure_title)
    expect(page).to have_text(@campaign_log_entry.session_num)
    expect(page).to have_text(@campaign_log_entry.date_played.strftime('%Y-%m-%d %H:%M'))
    expect(page).to have_text(@campaign_log_entry.xp_gained)
    expect(page).to have_text(@campaign_log_entry.gp_gained.floor)
    expect(page).to have_text(@campaign_log_entry.downtime_gained)
    expect(page).to have_text(@campaign_log_entry.location_played)
    expect(page).to have_text(@campaign_log_entry.notes)
  end
end
