require "rails_helper"

RSpec.feature "Character Log Entries", type: :feature, js: true do
  before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user, scope: :user)
    @character = FactoryBot.create(:character, user: @user, name: "Test Character")
    @adventure = FactoryBot.create(:adventure, name: "Lost Mines of Phandelver")
  end

  scenario "Create a Character Log Entry" do
    @character_entry_count = CharacterLogEntry.count
    visit user_character_path(@user, @character)

    click_button "New Entry"
    click_link "Game Log"

    within("#character-log-entry-main-form") do
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

    expect(Character.count).to have_text(@character_entry_count + 1)

    expect(page).to have_text("2016-08-01 19:00")
    expect(page).to have_text("Lost Mines of Phandelver")
    expect(page).to have_text("22")
    expect(page).to have_text("1001")
    expect(page).to have_text("333")
    expect(page).to have_text("111")

    click_link "Show"
    #find_link("Show").trigger("click") # hack to fix previous line

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

    expect(page).to have_text("Some DM")
    expect(page).to have_text("66666666")
  end
end
