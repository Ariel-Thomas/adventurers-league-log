require 'rails_helper'

RSpec.feature 'Characters page', type: :feature, js: true do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user, scope: :user)
    @campaign  = FactoryGirl.create(:campaign, users: [@user])

    @other_user = FactoryGirl.create(:user)
    @character = FactoryGirl.create(:character, user: @other_user, publicly_visible: false)
  end

  scenario 'DMs cannot see character show page for characters not in campaign' do
    visit user_character_path(@other_user, @character)

    expect(page).to have_text("You are not authorized to perform this action.")
  end

  context 'character part of campaign user is dming' do
    before do
      @campaign.characters = [@character]
    end

    scenario 'DMs can see character show page for characters in campaign' do
      visit user_character_path(@other_user, @character)

      expect(page).to have_text(@character.name)
      expect(page).to have_text(@character.race)
      expect(page).to have_text(@character.class_and_levels)
      expect(page).to have_text(@character.background)
      expect(page).to have_text(@character.lifestyle_name)
      expect(page).to have_text(@character.faction_name)
    end
  end

end
