require 'rails_helper'

RSpec.feature 'Trade Log Entry page', type: :feature, js: true do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user, scope: :user)
    @character = FactoryGirl.create(:character, user: @user)
  end

  scenario 'Adding trade log hides old magic item and shows new magic item' do
    @log_entry = FactoryGirl.create(:character_log_entry)
    @magic_item = FactoryGirl.create(:magic_item, name: 'Staff of Power', rarity: 'rare', log_entry: @log_entry)
    @character.character_log_entries = [@log_entry]
    visit user_character_path(@user, @character)

    click_button 'New Log Entry'
    click_link 'Trade Log'

    fill_in 'Date Traded', with: '' # HACK: for datepicker
    fill_in 'Date Traded',             with: '2016-01-01'
    fill_in 'Downtime +/-',            with: '-15'
    select  'Staff of Power (rare)',   from: 'Traded Magic Item'

    within('.magic-item') do
      fill_in 'Name',  with: 'Sword of Awesome'
      select  'Rare',  from: 'Rarity'
      fill_in 'Notes', with: 'Grants a +5 on all attack and damage rolls'
    end

    click_button 'Save'

    expect(page).to have_text('Total Magic Items: 1')
    expect(page).to have_text('Magic Items: Sword of Awesome')

    expect(page).to have_text('2016-01-01')
    expect(page).to have_text('-15')
    expect(page).to have_text('Staff of Power > Sword of Awesome')
  end
end
