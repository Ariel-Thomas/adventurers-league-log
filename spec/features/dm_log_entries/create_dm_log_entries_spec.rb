require 'rails_helper'

RSpec.feature 'DM Log Entries', type: :feature do
  before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user, scope: :user)
    @character = FactoryBot.create(:character, user: @user, name: 'Test Character')
    @adventure = FactoryBot.create(:adventure, name: 'Lost Mines of Phandelver')
  end

  scenario 'Create a DM Log Entry' do
    @dm_log_entry_count = DmLogEntry.count
    visit user_dm_log_entries_path(@user)

    # click_link 'New Entry'
    all('a', text: 'New Entry').first.click

    within('#dm-log-entry-main-form') do
      fill_in 'Adventure Title', with: 'Lost Mines of Phandelver'

      fill_in 'Session',            with: '22'
      fill_in 'Date DMed',          with: '' #Hack for calendar popout
      fill_in 'Date DMed',          with: '2016-08-01 19:00'

      fill_in 'Length (Hours)',     with: '8'
      fill_in 'Player Level',       with: '7'
      fill_in 'XP Gained',          with: '1001'
      fill_in 'GP +/-',             with: '333'
      fill_in 'Downtime +/-',       with: '111'
      fill_in 'Renown',             with: '44'
      fill_in 'Mission',            with: '55'
      fill_in 'Location',           with: 'Origins'
      fill_in 'Notes',              with: 'Some Words'

      fill_in 'Date Assigned',      with: '' #Hack for calendar popout
      fill_in 'Date Assigned',      with: '2017-08-01 12:00'
      select  'Test Character',     from: 'Character to Apply Rewards'
    end

    click_button 'Save'

    expect(Character.count).to have_text(@dm_log_entry_count + 1)

    expect(page).to have_text('2016-08-01 19:00')
    expect(page).to have_text('Lost Mines of Phandelver')
    expect(page).to have_text('22')
    expect(page).to have_text('1001')
    expect(page).to have_text('333')
    expect(page).to have_text('111')
    expect(page).to have_text('Test Character')

    click_link 'Show'
    #find_link('Show').trigger('click') # hack to fix previous line

    expect(page).to have_text('Lost Mines of Phandelver')
    expect(page).to have_text('22')
    expect(page).to have_text('2016-08-01 19:00')
    expect(page).to have_text('8')
    expect(page).to have_text('7')
    expect(page).to have_text('1001')
    expect(page).to have_text('333')
    expect(page).to have_text('111')
    expect(page).to have_text('44')
    expect(page).to have_text('55')
    expect(page).to have_text('Origins')
    expect(page).to have_text('Some Words')
    expect(page).to have_text('2017-08-01 12:00')
    expect(page).to have_text('Test Character')
  end

  scenario 'automatically calculate XP', js: true do
    visit user_dm_log_entries_path(@user)
    all('a', text: 'New Entry').first.click

    within('#dm-log-entry-main-form') do
      fill_in 'Adventure Title', with: 'Lost Mines of Phandelver'

      fill_in 'Session',            with: '22'
      fill_in 'Length (Hours)',     with: '10'
      fill_in 'Player Level',       with: '7'
    end

    click_button 'Save'

    expect(page).to have_text('Lost Mines of Phandelver')
    expect(page).to have_text('3250')
    expect(page).to have_text('1625')
    expect(page).to have_text('25')
    expect(page).to have_text('2')
  end
end
