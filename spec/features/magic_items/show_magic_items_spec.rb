require 'rails_helper'

RSpec.feature 'Show Magic items', type: :feature, js: true do
  before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user, scope: :user)
    @character = FactoryBot.create(:character, user: @user)
  end

  context 'Character has no log entries with magic item' do
    scenario 'Should have none shown on character page' do
      visit user_character_path(@user, @character)

      expect(page).to have_text('Total Magic Items: 0')
    end
  end

  context 'Character has log entry with magic item' do
    before(:each) do
      @log_entry = FactoryBot.create(:character_log_entry, characters: [@character])
      @magic_item = FactoryBot.create(:magic_item, name: 'Staff of Power', log_entry: @log_entry, character: @character)
      @character.character_log_entries = [@log_entry]
    end

    scenario 'Should be shown on character page' do
      visit user_character_path(@user, @character)

      expect(page).to have_text('Total Magic Items: 1')
      expect(page).to have_text(@magic_item.name)
    end

    scenario 'Should be shown on log page' do
      visit user_character_character_log_entry_path(@user, @character, @log_entry)

      expect(page).to have_text(@magic_item.name)
    end
  end

  context 'Character has log entries with many magic items' do
    before(:each) do
      @log_entry1 = FactoryBot.create(:character_log_entry, characters: [@character])
      @magic_item1 = FactoryBot.create(:magic_item, name: 'Staff of Power', log_entry: @log_entry1, character: @character)
      @magic_item2 = FactoryBot.create(:magic_item, name: 'Cool Belt', log_entry: @log_entry1, character: @character)

      @log_entry2 = FactoryBot.create(:character_log_entry, characters: [@character])
      @log_entry3 = FactoryBot.create(:character_log_entry, characters: [@character])
      @magic_item3 = FactoryBot.create(:magic_item, name: 'Awesome Armor', log_entry: @log_entry3, character: @character)
      @magic_item4 = FactoryBot.create(:magic_item, name: 'Big Sword', log_entry: @log_entry3, character: @character)

      @character.character_log_entries = [@log_entry1, @log_entry2, @log_entry3]
    end

    scenario 'Should be shown on character page' do
      visit user_character_path(@user, @character)

      expect(page).to have_text('Total Magic Items: 4')
      expect(page).to have_text(@magic_item1.name)
      expect(page).to have_text(@magic_item2.name)
      expect(page).to have_text(@magic_item3.name)
      expect(page).to have_text(@magic_item4.name)
    end

    scenario 'Should be shown on log pages' do
      visit user_character_character_log_entry_path(@user, @character, @log_entry1)

      expect(page).to have_text(@magic_item1.name)
      expect(page).to have_text(@magic_item2.name)

      visit user_character_character_log_entry_path(@user, @character, @log_entry2)

      expect(page).to_not have_text(@magic_item1.name)
      expect(page).to_not have_text(@magic_item2.name)
      expect(page).to_not have_text(@magic_item3.name)
      expect(page).to_not have_text(@magic_item4.name)

      visit user_character_character_log_entry_path(@user, @character, @log_entry3)

      expect(page).to have_text(@magic_item3.name)
      expect(page).to have_text(@magic_item4.name)
    end
  end
end
