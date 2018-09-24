require "rails_helper"

RSpec.feature "DM Log Entries", type: :feature, js: true do
  before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user, scope: :user)
    @dm_log_entry = FactoryBot.create(:dm_log_entry, user: @user)
    @character = FactoryBot.create(:character, user: @user, name: "Test Character")
    @adventure = FactoryBot.create(:adventure, name: "Lost Mines of Phandelver")
  end

  scenario "Edit a DM Log Entry" do
    visit user_dm_log_entries_path(@user)

    click_link "Edit", title: "Edit Log Entry"

    within("#edit_dm_log_entry_1") do
      check "Old Format", allow_label_click: true
      fill_in "Adventure Title", with: "Lost Mines of Phandelver"

      fill_in "Session",            with: "22"
      fill_in "Date DMed",          with: "" #Hack for calendar popout
      fill_in "Date DMed",          with: "2016-08-01 19:00"
      fill_in "XP Gained",          with: "1001"
      fill_in "GP +/-",             with: "333"
      fill_in "Downtime +/-",       with: "111"
      fill_in "Renown",             with: "44"
      fill_in "Mission",            with: "55"
      set_location "Origins"
      fill_in_editor_field "Some Words"

      fill_in "Date Assigned",      with: "" #Hack for calendar popout
      fill_in "Date Assigned",      with: "2017-08-01 12:00"
      select  "Test Character",     from: "Character to Apply Rewards"
    end

    click_button "Save"

    expect(page).to have_text("2016-08-01 19:00")
    expect(page).to have_text("Lost Mines of Phandelver")
    expect(page).to have_text("22")
    expect(page).to have_text("1001")
    expect(page).to have_text("333")
    expect(page).to have_text("111")
    expect(page).to have_text("Test Character")

    expect(page).to have_text("DM Log Entries")

    click_link "Show"

    expect(page).to have_text("Lost Mines of Phandelver")
    expect(page).to have_text("22")
    expect(page).to have_text("2016-08-01 19:00")
    expect(page).to have_text("1001")
    expect(page).to have_text("333")
    expect(page).to have_text("111")
    expect(page).to have_text("44")
    expect(page).to have_text("55")
    expect(page).to have_text("Origins")
    expect(page).to have_text("Some Words")
    expect(page).to have_text("2017-08-01 12:00")
    expect(page).to have_text("Test Character")
  end

  context "via character page" do
    before(:each) do
      @dm_log_entry.characters = [@character]
      @dm_log_entry.save!
    end

    scenario "Edit a DM Log Entry" do
      visit user_character_path(@user, @character)
      within(".list-buttons .hidden-xs") do
        click_link "DM Logs"
      end

      click_link "Edit Log Entry"
      # find_link("Edit").trigger("click") # hack to fix previous line

      within("#edit_dm_log_entry_1") do
        check "Old Format", allow_label_click: true
        fill_in "Adventure Title", with: "Lost Mines of Phandelver"

        fill_in "Session",            with: "22"
        fill_in "Date DMed",          with: "" #Hack for calendar popout
        fill_in "Date DMed",          with: "2016-08-01 19:00"
        fill_in "XP Gained",          with: "1001"
        fill_in "GP +/-",             with: "333"
        fill_in "Downtime +/-",       with: "111"
        fill_in "Renown",             with: "44"
        fill_in "Mission",            with: "55"
        set_location "Origins"
        fill_in_editor_field "Some Words"

        fill_in "Date Assigned",      with: "" #Hack for calendar popout
        fill_in "Date Assigned",      with: "2017-08-01 12:00"
        select  "Test Character",     from: "Character to Apply Rewards"
      end

      click_button "Save"

      expect(page).to have_text("2017-08-01 12:00")
      expect(page).to have_text("Lost Mines of Phandelver")
      expect(page).to have_text("22")
      expect(page).to have_text("1001")
      expect(page).to have_text("333")
      expect(page).to have_text("111")
      expect(page).to have_text("Test Character")

      expect(page).to_not have_text("DM Log Entries")

      click_link "Show"

      expect(page).to have_text("Lost Mines of Phandelver")
      expect(page).to have_text("22")
      expect(page).to have_text("2016-08-01 19:00")
      expect(page).to have_text("1001")
      expect(page).to have_text("333")
      expect(page).to have_text("111")
      expect(page).to have_text("44")
      expect(page).to have_text("55")
      expect(page).to have_text("Origins")
      expect(page).to have_text("Some Words")
      expect(page).to have_text("2017-08-01 12:00")
      expect(page).to have_text("Test Character")
    end
  end
end
