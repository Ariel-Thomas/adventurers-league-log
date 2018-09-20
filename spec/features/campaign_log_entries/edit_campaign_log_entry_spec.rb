require 'rails_helper'

RSpec.feature 'Campaign Log Entries', type: :feature, js: true do
  before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user, scope: :user)
    @adventure = FactoryBot.create(:adventure, name: 'Lost Mines of Phandelver')

    @character1 = FactoryBot.create(:character)
    @character2 = FactoryBot.create(:character)
    @character3 = FactoryBot.create(:character)
    @character4 = FactoryBot.create(:character)
    @character5 = FactoryBot.create(:character)
    @character6 = FactoryBot.create(:character)

    @campaign            = FactoryBot.create(:campaign, users: [@user])
    @campaign.characters = [@character1, @character2, @character3, @character4, @character5, @character6]

    @campaign_log_entry = FactoryBot.create(:campaign_log_entry, campaign: @campaign, user: @user, dm_name: @user.name, dm_dci_number: @user.dci_num)
    @campaign_log_entry.characters = [@character1, @character3, @character5]
  end

  scenario 'Edit a Campaign Log Entry' do
    @campaign_log_entry = CampaignLogEntry.count
    visit user_campaign_path(@user, @campaign)

    click_link 'Edit'

    within('#campaign-log-entry-main-form') do
      check 'Old Format', allow_label_click: true
      fill_in 'Adventure Title', with: 'Lost Mines of Phandelver'

      fill_in 'Session',            with: '22'
      fill_in 'Date Played',        with: '' #Hack for calendar popout
      fill_in 'Date Played',        with: '2016-08-01 19:00'
      fill_in 'XP Gained',          with: '1001'
      fill_in 'GP +/-',             with: '333'
      fill_in 'Downtime',   with: '111'
      fill_in 'Renown',             with: '44'
      fill_in 'Mission',            with: '55'
      check 'Manual Entry', allow_label_click: true
      fill_in 'Location',           with: 'Origins'
      # binding.pry
      fill_in_editor_field "Some Words"
    end

    check   @character4.name, allow_label_click: true
    uncheck @character5.name, allow_label_click: true

    click_button 'Save'

    expect(CampaignLogEntry.count).to be(@campaign_log_entry)

    check 'Old Format', allow_label_click: true
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

    expect(page).to have_text(@user.name)
    expect(page).to have_text(@user.dci_num)

    expect(page).to have_text(@character1.name)
    expect(page).to have_text(@character3.name)
    expect(page).to have_text(@character4.name)
  end
end
