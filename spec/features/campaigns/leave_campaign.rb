require 'rails_helper'

RSpec.feature 'Campaigns', type: :feature do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user, scope: :user)
  end

  context 'As a DM' do
    before(:each) do
      @campaign = FactoryGirl.create(:campaign, user: @user)
    end

    scenario 'Leave a campaign' do
      @character_count = Campaign.count
      visit root_path

      all('a', text: 'Campaigns BETA').first.click
      click_link 'Delete'

      visit user_campaigns_path(@user)

      expect(page).to_not have_text(@campaign.name)
      expect(Campaign.count).to be(@character_count - 1)
    end
  end

  context 'As a player' do
    before(:each) do
      @campaign  = FactoryGirl.create(:campaign)
      @character = FactoryGirl.create(:character,
                                      user: @user, name: 'Test Character')
      @campaign.characters = [@character]
    end

    scenario 'Leave a campaign' do
      @character_count = @campaign.characters.count
      visit root_path

      all('a', text: 'Campaigns BETA').first.click
      click_link 'Delete'

      visit user_campaigns_path(@user)

      expect(page).to_not have_text(@campaign.name)
      expect(@campaign.characters.count).to be(@character_count - 1)
    end
  end
end
