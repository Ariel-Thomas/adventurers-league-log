require "rails_helper"

RSpec.feature "Characters page", :type => :feature, js: true do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user, :scope => :user)
    @character       = FactoryGirl.create(:character, user: @user)
  end

  scenario "Character show page should have information" do
    visit user_character_path(@user, @character)

    expect(page).to have_text(@character.name)
    expect(page).to have_text(@character.season_origin_name)
    expect(page).to have_text(@character.race)
    expect(page).to have_text(@character.class_and_levels)
    expect(page).to have_text(@character.background)    
    expect(page).to have_text(@character.lifestyle_name)
    expect(page).to have_text(@character.faction_name)  end
end