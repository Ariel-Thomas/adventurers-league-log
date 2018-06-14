require 'rails_helper'

RSpec.feature 'Campaigns', type: :feature do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user, scope: :user)
    @character = FactoryGirl.create(:character,
                                    user: @user, name: 'Test Character')
    @campaign  = FactoryGirl.create(:campaign, users_can_join: true, dms_can_join: true)
  end

  scenario 'Join a campaign as a player' do
    @campaigns = @character.campaigns.count
    visit root_path

    all('a', text: 'Campaigns BETA').first.click
    # click_link 'Join Campaign'
    all('a', text: 'Join Campaign').first.click

    fill_in 'Token *', with: @campaign.token
    select @character.name, from: 'Character *'

    click_button 'Save'

    expect(page).to have_text("Storm King's Thunder Table")
    expect(page).to have_text('Users Can Join:
true')
    expect(page).to have_text('Publicly Visible:
true')
    expect(@character.campaigns.count).to be(@campaigns + 1)
  end

  scenario 'Join a campaign as a DM' do
    @campaigns = @user.campaigns.count
    visit root_path

    all('a', text: 'Campaigns BETA').first.click
    # click_link 'Join Campaign'
    all('a', text: 'Join As DM').first.click

    fill_in 'Token *', with: @campaign.dm_token
    click_button 'Save'

    expect(page).to have_text("Storm King's Thunder Table")
    expect(page).to have_text('Users Can Join:
true')
    expect(page).to have_text('Publicly Visible:
true')
    expect(@user.campaigns.count).to be(@campaigns + 1)
  end

end
