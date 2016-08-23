require 'rails_helper'

RSpec.feature 'Show Trade Log Entry', type: :feature, js: true do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user, scope: :user)
    @character  = FactoryGirl.create(:character, user: @user)
    @log_entry  = FactoryGirl.create(:character_log_entry)
    @magic_item = FactoryGirl.create(:magic_item, name: 'Staff of Power', log_entry: @log_entry)
  end

  context 'Character has no log entries with magic item' do
    scenario 'Should have none shown on character page' do
      visit user_character_path(@user, @character)

      expect(page).to have_text('Total Magic Items: 0')
    end
  end

  context 'Character has trade log entry with magic item' do
    before(:each) do
      @trade_log_entry = FactoryGirl.create(:trade_log_entry, traded_magic_item: @magic_item)
      @received_magic_item = FactoryGirl.create(:magic_item, name: 'Sword of Awesome', log_entry: @trade_log_entry)

      @character.log_entries = [@log_entry, @trade_log_entry]
    end

    scenario 'Should be shown on character page' do
      visit user_character_path(@user, @character)

      expect(page).to have_text('Total Magic Items: 1')
      expect(page).to have_text("Magic Items: #{@received_magic_item.name}")
    end

    scenario 'Trade log page should have information' do
      visit user_character_trade_log_entry_path(@user, @character, @trade_log_entry)

      expect(page).to have_text(@trade_log_entry.date_played)
      expect(page).to have_text(@trade_log_entry.downtime_gained)
      expect(page).to have_text(@trade_log_entry.notes)

      expect(page).to have_text(@magic_item.name)
      expect(page).to have_text(@magic_item.rarity.titleize)
      expect(page).to have_text(@magic_item.notes)

      expect(page).to have_text(@received_magic_item.name)
      expect(page).to have_text(@received_magic_item.rarity.titleize)
      expect(page).to have_text(@received_magic_item.notes)
    end
  end
end
