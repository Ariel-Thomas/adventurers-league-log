require 'rails_helper'

RSpec.feature 'Campaigns', type: :feature do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user, scope: :user)
    @campaign  = FactoryGirl.create(:campaign, users: [@user])
  end

  scenario 'Edit a campaign' do
    @campaigns = Campaign.count
    visit root_path
    all('a', text: 'Campaigns BETA').first.click

    click_link 'Edit'

    within('#campaign-form') do
      fill_in 'Name', with: "Curse of Strahd"
      uncheck   'Users Can Join'
      uncheck   'DMs Can Join'
      uncheck   'Publicly Visible'
    end

    click_button 'Save'

    expect(Campaign.count).to be(@campaigns)

    expect(page).to have_text("Curse of Strahd")
    expect(page).to have_text('Users Can Join:
false')
    expect(page).to have_text('DMs Can Join:
false')
    expect(page).to have_text('Publicly Visible:
false')

    expect(page).to have_text(Campaign.last.token)
    expect(page).to have_text(Campaign.last.dm_token)

    click_link 'Campaigns'

    expect(page).to have_text("Curse of Strahd")
  end
end
