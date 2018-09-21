require "rails_helper"

RSpec.feature "Trade Log Entry page", type: :feature, js: true do
  before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user, scope: :user)
    @character = FactoryBot.create(:character, user: @user)

    @log_entry = FactoryBot.create(:character_log_entry, characters: [@character])
    @magic_item = FactoryBot.create(:magic_item, name: "Staff of Power", rarity: "rare", log_entry: @log_entry, character: @character)
  end

  scenario "Adding trade log hides old magic item and shows new magic item", skip: true do
    @character.character_log_entries = [@log_entry]
    visit user_character_path(@user, @character)

    click_button "New Entry"
    click_link "Trade Log"

    fill_in "Date Traded", with: "" # HACK: for datepicker
    fill_in "Date Traded",             with: "2016-01-01"
    fill_in "Downtime +/-",            with: "-15"
    select  "Staff of Power (rare)",   from: "Traded Magic Item"

    within(".magic-item") do
      fill_in "Name",  with: "Sword of Awesome"
      select  "Rare",  from: "Rarity"
      fill_in "Notes", with: "Grants a +5 on all attack and damage rolls"
    end

    click_button "Save"

    expect(page).to have_text("Total Magic Items: 1")
    expect(page).to have_text("Magic Items: Sword of Awesome")

    expect(page).to have_text("2016-01-01")
    expect(page).to have_text("-15")
    expect(page).to have_text("Staff of Power > Sword of Awesome")
  end

  context "with character that has trade log entry with magic item" do
    before(:each) do
      @magic_item = FactoryBot.create(:magic_item, name: "Rod of Wonder", rarity: "legendary", log_entry: @log_entry, character: @character)

      @trade_log_entry = FactoryBot.create(:trade_log_entry, traded_magic_item: @magic_item)
      @received_magic_item = FactoryBot.create(:magic_item, name: "Sword of Awesome", log_entry: @trade_log_entry, character: @character)

      @character.log_entries = [@log_entry, @trade_log_entry]
    end

    scenario "Edit trade log", skip: true do
      visit user_character_path(@user, @character)

      within(".trade-log") do
        click_link("Edit")
      end

      fill_in "Date Traded", with: "" # HACK: for datepicker
      fill_in "Date Traded",               with: "2016-01-01"
      fill_in "Downtime +/-",              with: "-10"
      select  "Rod of Wonder (legendary)", from: "Traded Magic Item"

      within(".magic-item") do
        fill_in "Name",  with: "Axe of Coolness"
        select  "Uncommon",  from: "Rarity"
        fill_in "Notes", with: "Doesn't do anything"
      end

      click_button "Save"

      expect(page).to have_text("Total Magic Items: 2")
      expect(page).to have_text("Staff of Power,\nAxe of Coolness")

      expect(page).to have_text("2016-01-01")
      expect(page).to have_text("-10")
      expect(page).to have_text("Rod of Wonder > Axe of Coolness")
    end

    scenario "Delete trade log" do
      visit user_character_path(@user, @character)

      within(".trade-log") { click_link("Delete") }
      accept_confirm

      expect(page).to have_text("Rod of Wonder, Staff of Power")

      expect(page).to_not have_text(@trade_log_entry.date_played)
      expect(page).to_not have_text(@trade_log_entry.magic_items_list(@character))
    end
  end
end
