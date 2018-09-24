require "rails_helper"

RSpec.feature "Character Log Entries", type: :feature, js: true do
  before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user, scope: :user)
    @character = FactoryBot.create(:character, user: @user, name: "Test Character")
    @adventure = FactoryBot.create(:adventure, name: "Lost Mines of Phandelver")
  end

  context "When a user creates a Character Log Entry" do
    before(:each) do
      @player_dms_count = PlayerDm.count

      visit user_character_path(@user, @character)

      click_button "New Entry"
      click_link "Game Log"

      within("#character-log-entry-main-form") do
        # check "Old Format", allow_label_click: true
        fill_in "Adventure Title", with: "Lost Mines of Phandelver"

        fill_in "Session",            with: "22"
        fill_in "Date Played",        with: "" #Hack for calendar popout
        fill_in "Date Played",        with: "2016-08-01 19:00"
        fill_in "XP Gained",          with: "1001"
        fill_in "GP +/-",             with: "333"
        fill_in "Downtime +/-",       with: "111"
        fill_in "Renown",             with: "44"
        fill_in "Mission",            with: "55"

        set_location "Origins"
        set_dm_info "Some DM", "66666666"

        fill_in_editor_field "Some Words"
      end

      click_button "Save"
    end

    it "should create a player dm" do
      expect(PlayerDm.count).to have_text(@player_dms_count + 1)

      visit user_player_dms_path(@user)

      expect(page).to have_text("Some DM")
      expect(page).to have_text("66666666")
    end
  end
end
