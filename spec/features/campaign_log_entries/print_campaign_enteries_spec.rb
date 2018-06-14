require 'rails_helper'

RSpec.feature 'Campaign Log Entries', type: :feature do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user, scope: :user)
    @character    = FactoryGirl.create(:character, user: @user)
    @campaign_log_entry = FactoryGirl.create(:campaign_log_entry)
    @campaign_log_entry.characters = [@character]
  end

  scenario 'Campaign Log Entry print full page should have information' do
    visit user_character_path(@user, @character)
    all('a', text: 'Print Full').first.click

    expect(page).to have_text(@campaign_log_entry.adventure_title)
    expect(page).to have_text(@campaign_log_entry.session_num)
    expect(page).to have_text(@campaign_log_entry.xp_gained)
    expect(page).to have_text(@campaign_log_entry.gp_gained.floor)
    expect(page).to have_text(@campaign_log_entry.downtime_gained)
    expect(page).to have_text(@campaign_log_entry.notes)
    expect(page).to have_text(@campaign_log_entry.date_played.strftime('%Y-%m-%d %H:%M'))
  end

  scenario 'Campaign Log Entry print condensed page should have information' do
    visit user_character_path(@user, @character)
    all('a', text: 'Print Condensed').first.click

    expect(page).to have_text(@campaign_log_entry.adventure_title)
    expect(page).to have_text(@campaign_log_entry.session_num)
    expect(page).to have_text(@campaign_log_entry.xp_gained)
    expect(page).to have_text(@campaign_log_entry.gp_gained.floor)
    expect(page).to have_text(@campaign_log_entry.downtime_gained)
    expect(page).to have_text(@campaign_log_entry.notes)
    expect(page).to have_text(@campaign_log_entry.date_played.strftime('%Y-%m-%d %H:%M'))
  end
end
