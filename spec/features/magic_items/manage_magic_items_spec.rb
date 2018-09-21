require "rails_helper"

RSpec.feature "Manage magic items", type: :feature, js: true do
  before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user, scope: :user)
    @character = FactoryBot.create(:character, user: @user)
  end

  context "on character log sheet" do
    scenario "add log entry with magic item" do
      visit user_character_path(@user, @character)

      click_button "New Entry"
      click_link "Game Log"
      click_link "Add Magic Item"

      within all("#magic-items-form .magic-item").last do
        fill_in "Name",     with: "Sword +1"
        select  "Rare",     from: "Rarity"
        fill_in "Location", with: "A stone"
        fill_in "Table",    with: "G"
        fill_in "Result",   with: "22"
        fill_in_editor_field "Grants a +1 on all attack and damage rolls"
      end

      click_button "Save"

      expect(page).to have_text("Log Entries")

      click_link "Show"
      expect(page).to have_text("Sword +1")
      expect(page).to have_text("Rare")
      expect(page).to have_text("A stone")
      expect(page).to have_text("G")
      expect(page).to have_text("22")
      expect(page).to have_text("Grants a +1 on all attack and damage rolls")
    end

    scenario "add log entry with magic item that doesn't count" do
      visit user_character_path(@user, @character)

      click_button "New Entry"
      click_link "Game Log"
      click_link "Add Magic Item"

      within all("#magic-items-form .magic-item").last do
        fill_in "Name",     with: "Sword +1"
        find("label[for='character_log_entry_magic_items_attributes_1_not_included_in_count']").click()
      end

      click_button "Save"

      expect(page).to have_text("Log Entries")
      expect(page).to have_text("Sword +1")
    end

    context "with existing log entry" do
      before(:each) do
        @log_entry = FactoryBot.create(:character_log_entry)
        @magic_item = FactoryBot.create(:magic_item,
                                         name: "Staff of Power",
                                         log_entry: @log_entry,
                                         character: @character)
        @character.character_log_entries = [@log_entry]
      end

      scenario "add to existing log entry with magic item" do
        visit user_character_path(@user, @character)

        click_link "Edit", title: "Edit Log Entry"
        click_link "Add Magic Item"

        within all("#magic-items-form .magic-item").last do
          fill_in "Name", with: "Sword +1"
          select  "Legendary", from: "Rarity"
          fill_in "Location", with: "A stone"
          fill_in "Table",    with: "G"
          fill_in "Result",   with: "22"
          fill_in_editor_field "Grants a +1 on all attack and damage rolls"
        end

        click_button "Save"

        expect(page).to have_text("Log Entries")

        click_link "Show"
        expect(page).to have_text(@magic_item.name)
        expect(page).to have_text(@magic_item.rarity.titleize)
        expect(page).to have_text(@magic_item.location_found)
        expect(page).to have_text(@magic_item.table)
        expect(page).to have_text(@magic_item.table_result)
        expect(page).to have_text(@magic_item.notes)

        expect(page).to have_text("Sword +1")
        expect(page).to have_text("Legendary")
        expect(page).to have_text("A stone")
        expect(page).to have_text("G")
        expect(page).to have_text("22")
        expect(page).to have_text("Grants a +1 on all attack and damage rolls")
      end

      scenario "remove from existing log entry with magic item" do
        visit user_character_path(@user, @character)

        click_link "Edit", title: "Edit Log Entry"
        click_link "Remove"
        click_button "Save"

        expect(page).to have_text("Log Entries")

        click_link "Show"
        expect(page).to_not have_text(@magic_item.name)
        expect(page).to_not have_text(@magic_item.rarity.titleize)
        expect(page).to_not have_text(@magic_item.notes)
      end
    end
  end

  context "on dm log sheet" do
    scenario "add log entry with magic item" do
      visit user_dm_log_entries_path(@user)

      click_link "New Entry"
      click_link "Add Magic Item"

      within("#dm-log-entry-main-form") do
        select @character.name, from: "Character to Apply Rewards"
      end

      within all("#magic-items-form .magic-item").last do
        fill_in "Name",  with: "Sword +1"
        select  "Rare",  from: "Rarity"
        fill_in "Location", with: "A stone"
        fill_in "Table",    with: "G"
        fill_in "Result",   with: "22"
        fill_in_editor_field "Grants a +1 on all attack and damage rolls"
      end

      click_button "Save"

      expect(page).to have_text("DM Log Entries")

      click_link "Show"
      expect(page).to have_text("Sword +1")
      expect(page).to have_text("Rare")
      expect(page).to have_text("A stone")
      expect(page).to have_text("G")
      expect(page).to have_text("22")
      expect(page).to have_text("Grants a +1 on all attack and damage rolls")

      visit user_character_path(@user, @character)
      click_link "+DM Logs"
      expect(page).to have_text("Sword +1")
    end

    context "with existing log entry" do
      before(:each) do
        @log_entry = FactoryBot.create(:dm_log_entry)
        @magic_item = FactoryBot.create(:magic_item,
                                         name: "Staff of Power",
                                         log_entry: @log_entry,
                                         character: @character)
        @user.dm_log_entries = [@log_entry]
      end

      scenario "add to existing log entry with magic item" do
        visit user_dm_log_entries_path(@user)

        click_link "Edit"
        click_link "Add Magic Item"

        within("#dm-log-entry-main-form") do
          select @character.name, from: "Character to Apply Rewards"
        end

        within all("#magic-items-form .magic-item").last do
          fill_in "Name",  with: "Sword +1"
          select  "Legendary", from: "Rarity"
          fill_in "Location", with: "A stone"
          fill_in "Table",    with: "G"
          fill_in "Result",   with: "22"
          fill_in_editor_field "Grants a +1 on all attack and damage rolls"
        end

        click_button "Save"

        expect(page).to have_text("Log Entries")

        click_link "Show"
        expect(page).to have_text(@magic_item.name)
        expect(page).to have_text(@magic_item.rarity.titleize)
        expect(page).to have_text(@magic_item.location_found)
        expect(page).to have_text(@magic_item.table)
        expect(page).to have_text(@magic_item.table_result)
        expect(page).to have_text(@magic_item.notes)

        expect(page).to have_text("Sword +1")
        expect(page).to have_text("Legendary")
        expect(page).to have_text("A stone")
        expect(page).to have_text("G")
        expect(page).to have_text("22")
        expect(page).to have_text("Grants a +1 on all attack and damage rolls")

        visit user_character_path(@user, @character)
        click_link "+DM Logs"
        expect(page).to have_text(@magic_item.name)
        expect(page).to have_text("Sword +1")
      end

      scenario "remove from existing log entry with magic item" do
        visit user_dm_log_entries_path(@user, @character)

        click_link "Edit"

        click_link "Remove"
        click_button "Save"

        expect(page).to have_text("Log Entries")

        click_link "Show"
        expect(page).to_not have_text(@magic_item.name)
        expect(page).to_not have_text(@magic_item.rarity.titleize)
        expect(page).to_not have_text(@magic_item.notes)

        visit user_character_path(@user, @character)
        click_link "+DM Logs"
        expect(page).to_not have_text(@magic_item.name)
      end
    end
  end

  context "campaign log sheet" do
    before(:each) do
      @campaign            = FactoryBot.create(:campaign, users: [@user])
      @campaign.characters = [@character]
    end

    scenario "add log entry with magic item" do
      visit user_campaign_path(@user, @campaign)

      click_link "New Entry"
      click_link "Add Magic Item"

      within all("#magic-items-form .magic-item").last do
        fill_in "Name",  with: "Sword +1"
        select  "Rare",  from: "Rarity"
        fill_in "Location", with: "A stone"
        fill_in "Table",    with: "G"
        fill_in "Result",   with: "22"
        fill_in_editor_field "Grants a +1 on all attack and damage rolls"

        select @character.name, from: "Character"
      end

      click_button "Save"

      expect(page).to have_text("Show Campaign")

      visit user_character_path(@character.user, @character)
      expect(page).to have_text("Sword +1")
    end
  end
end
