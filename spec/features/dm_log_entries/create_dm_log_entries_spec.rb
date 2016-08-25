require 'rails_helper'

RSpec.feature 'DM Log Entries', type: :feature do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user, scope: :user)
    @character = FactoryGirl.create(:character, user: @user, name: 'Test Character')
    @adventure = FactoryGirl.create(:adventure_form_input, name: 'Lost Mines of Phandelver')
  end

  scenario 'Create a DM Log Entry' do
    @dm_log_entry_count = DmLogEntry.count
    visit user_dm_log_entries_path(@user)

    click_link 'New Log Entry'

    within('#dm-log-entry-main-form') do
      select 'Lost Mines of Phandelver', from: 'Adventure Title'

      fill_in 'Session',            with: '22'
      fill_in 'Date DMed',          with: '' #Hack for calendar popout
      fill_in 'Date DMed',          with: '2016-08-01 19:00'
      fill_in 'XP Gained',          with: '1001'
      fill_in 'GP +/-',             with: '333'
      fill_in 'Downtime +/-',       with: '111'
      fill_in 'Renown',             with: '44'
      fill_in 'Mission',            with: '55'
      fill_in 'Location DMed',      with: 'Origins'
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
end
