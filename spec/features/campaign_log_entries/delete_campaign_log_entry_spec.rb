require "rails_helper"

RSpec.feature "Campaign Log Entries", type: :feature, js: true do
  before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user, scope: :user)
    @character1    = FactoryBot.create(:character, publicly_visible: true)
    @character2    = FactoryBot.create(:character, publicly_visible: true)

    @campaign            = FactoryBot.create(:campaign, users: [@user])
    @campaign.characters = [@character1, @character2]
    @campaign_log_entry = FactoryBot.create(:campaign_log_entry, campaign: @campaign, user: @user)
    @campaign_log_entry.characters = [@character1, @character2]
  end

  context "when deleted" do
    before(:each) do
      @campaign_log_entry_count = CampaignLogEntry.count
      visit user_campaign_path(@user, @campaign)

      click_link "Delete", title: "Delete Campaign"
      accept_confirm
    end

    scenario "the number of campaign log entries decreases" do
      sleep 1 # Have to allow time for controller to process deletion
      expect(CampaignLogEntry.count).to be(@campaign_log_entry_count - 1)
    end

    scenario "the flash is displayed with confirmation" do
      expect(page).to have_text("Successfully deleted Campaign Log Entry")
    end

    scenario "the log no longer shows on the campaign page" do
      visit user_campaign_path(@campaign.user, @campaign)

      expect(page).to_not have_text(@campaign_log_entry.date_played.strftime("%Y-%m-%d %H:%M"))
      expect(page).to_not have_text(@campaign_log_entry.adventure_title)
      expect(page).to_not have_text(@campaign_log_entry.session_num)
      expect(page).to_not have_text(@campaign_log_entry.xp_gained)
      expect(page).to_not have_text(@campaign_log_entry.gp_gained.floor)
      expect(page).to_not have_text(@campaign_log_entry.downtime_gained)
    end

    scenario "the log does not show on the character page" do
      visit user_character_path(@character1.user, @character1)

      expect(page).to_not have_text(@campaign_log_entry.date_played.strftime("%Y-%m-%d %H:%M"))
      expect(page).to_not have_text(@campaign_log_entry.adventure_title)
      expect(page).to_not have_text(@campaign_log_entry.session_num)
      expect(page).to_not have_text(@campaign_log_entry.xp_gained)
      expect(page).to_not have_text(@campaign_log_entry.gp_gained.floor)
      expect(page).to_not have_text(@campaign_log_entry.downtime_gained)
    end
  end
end
