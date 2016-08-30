require 'rails_helper'

RSpec.feature 'Campaign Log Entries', type: :feature do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user, scope: :user)

    @character1 = FactoryGirl.create(:character)
    @character2 = FactoryGirl.create(:character)
    @character3 = FactoryGirl.create(:character)
    @character4 = FactoryGirl.create(:character)
    @character5 = FactoryGirl.create(:character)
    @character6 = FactoryGirl.create(:character)

    @adventure = FactoryGirl.create(:adventure_form_input, name: 'Lost Mines of Phandelver')
    @campaign   = FactoryGirl.create(:campaign, user: @user)
    @campaign.characters = [@character1, @character2, @character3, @character4, @character5, @character6]
  end

  scenario 'Create a Campaign Log Entry' do
    @campaign_entry_count = CampaignLogEntry.count
    visit user_campaign_path(@user, @campaign)

    click_link 'New Log Entry'

    within('#campaign-log-entry-main-form') do
      select 'Lost Mines of Phandelver', from: 'Adventure Title'

      fill_in 'Session',            with: '22'
      fill_in 'Date Played',        with: '' #Hack for calendar popout
      fill_in 'Date Played',        with: '2016-08-01 19:00'
      fill_in 'XP Gained',          with: '1001'
      fill_in 'GP +/-',             with: '333'
      fill_in 'Downtime +/-',       with: '111'
      fill_in 'Renown',             with: '44'
      fill_in 'Mission',            with: '55'
      fill_in 'Location Played',    with: 'Origins'
      fill_in 'Notes',              with: 'Some Words'
    end

    click_button 'Save'

    expect(CampaignLogEntry.count).to be(@campaign_entry_count + 1)

    expect(page).to have_text('2016-08-01 19:00')
    expect(page).to have_text('Lost Mines of Phandelver')
    expect(page).to have_text('22')
    expect(page).to have_text('1001')
    expect(page).to have_text('333')
    expect(page).to have_text('111')

    click_link 'Show'

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

    expect(page).to have_text(@character1.name)
    expect(page).to have_text(@character2.name)
    expect(page).to have_text(@character3.name)
    expect(page).to have_text(@character4.name)
    expect(page).to have_text(@character5.name)
    expect(page).to have_text(@character6.name)

    expect(page).to have_text(@user.name)
    expect(page).to have_text(@user.dci_num)
  end
end
