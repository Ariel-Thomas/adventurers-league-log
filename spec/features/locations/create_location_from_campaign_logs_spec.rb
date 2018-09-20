require 'rails_helper'

RSpec.feature 'Campaign Log Entries', type: :feature do
  before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user, scope: :user)

    @character1 = FactoryBot.create(:character)
    @character2 = FactoryBot.create(:character)
    @character3 = FactoryBot.create(:character)
    @character4 = FactoryBot.create(:character)
    @character5 = FactoryBot.create(:character)
    @character6 = FactoryBot.create(:character)

    @adventure = FactoryBot.create(:adventure, name: 'Lost Mines of Phandelver')
    @campaign   = FactoryBot.create(:campaign, users: [@user])
    @campaign.characters = [@character1, @character2, @character3, @character4, @character5, @character6]
  end

  context 'Create a Campaign Log Entry' do
    before(:each) do
      @locations_count = Location.count
      visit user_campaign_path(@user, @campaign)

      click_link 'New Entry'

      within('#campaign-log-entry-main-form') do
        fill_in 'Adventure Title', with: 'Lost Mines of Phandelver'

        fill_in 'Session',            with: '22'
        fill_in 'Date Played',        with: '' #Hack for calendar popout
        fill_in 'Date Played',        with: '2016-08-01 19:00'
        fill_in 'XP Gained',          with: '1001'
        fill_in 'GP +/-',             with: '333'
        fill_in 'Downtime&nbsp+/-',   with: '111'
        fill_in 'Renown',             with: '44'
        fill_in 'Mission',            with: '55'
        fill_in 'Location',           with: 'Origins'
        fill_in 'Notes',              with: 'Some Words'
      end

      click_button 'Save'
    end

    it 'should create a location' do
      expect(Location.count).to have_text(@locations_count + 1)

      visit user_locations_path(@user)

      expect(page).to have_text('Origins')
    end
  end
end
