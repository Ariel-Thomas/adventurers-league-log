require "rails_helper"

RSpec.feature "Campaign Log Entries", type: :feature, js: true do
  before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user, scope: :user)
    @character    = FactoryBot.create(:character, user: @user)
    @campaign_log_entry = FactoryBot.create(:campaign_log_entry)
    @campaign_log_entry.characters = [@character]

    visit user_character_path(@user, @character)
    click_button "Print"
  end

  scenario "Campaign Log Entry print full page should have information" do
    click_link "Print Full"

    expect(page).to have_text(@campaign_log_entry.adventure_title)
    expect(page).to have_text(@campaign_log_entry.session_num)
    expect(page).to have_text(@campaign_log_entry.xp_gained.to_i)
    expect(page).to have_text(@campaign_log_entry.gp_gained.floor)
    expect(page).to have_text(@campaign_log_entry.downtime_gained.to_i)
    expect(page).to have_text(@campaign_log_entry.notes)
    expect(page).to have_text(@campaign_log_entry.date_played.strftime("%Y-%m-%d %H:%M"))
  end

  scenario "Campaign Log Entry print condensed page should have information" do
    click_link "Print Condensed"

    expect(page).to have_text(@campaign_log_entry.adventure_title)
    expect(page).to have_text(@campaign_log_entry.session_num)
    expect(page).to have_text(@campaign_log_entry.xp_gained)
    expect(page).to have_text(@campaign_log_entry.gp_gained.floor)
    expect(page).to have_text(@campaign_log_entry.downtime_gained.to_i)
    expect(page).to have_text(@campaign_log_entry.notes)
    expect(page).to have_text(@campaign_log_entry.date_played.strftime("%Y-%m-%d %H:%M"))
  end
end
