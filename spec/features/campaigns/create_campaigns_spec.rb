require 'rails_helper'

RSpec.feature 'Campaigns', type: :feature do
  before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user, scope: :user)
  end

  scenario 'Create a campaign' do
    @campaigns = Campaign.count
    visit root_path

    all('a', text: 'Campaigns BETA').first.click
    # click_link 'New Campaign'
    all('a', text: 'New Campaign').first.click

    within('#campaign-form') do
      fill_in 'Name', with: "Storm King's Thunder Table 1"
      check   'Users Can Join'
      check   'DMs Can Join'
      check   'Publicly Visible'
    end

    click_button 'Save'

    expect(Campaign.count).to be(@campaigns + 1)

    expect(page).to have_text("Storm King's Thunder Table 1")
    expect(page).to have_text('Users Can Join:
true')
    expect(page).to have_text('Publicly Visible:
true')

    expect(page).to have_text(Campaign.last.token)
    expect(page).to have_text(Campaign.last.dm_token)

    click_link 'Campaigns'

    expect(page).to have_text("Storm King's Thunder Table 1")
  end
end
