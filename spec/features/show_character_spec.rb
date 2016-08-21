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
    expect(page).to have_text(@character.race)
    expect(page).to have_text(@character.class_and_levels)
    expect(page).to have_text(@character.background)    
    expect(page).to have_text(@character.lifestyle_name)
    expect(page).to have_text(@character.faction_name)
  end

  context "faction ranks" do
    scenario "Zhentarim" do
      @faction = FactoryGirl.create(:faction, name: 'Zhentarim')
      @faction_rank = FactoryGirl.create(:faction_rank, name: "Fang", numerical_rank: 1, faction: @faction)
      @character.faction = @faction
      @character.save!

      visit user_character_path(@user, @character)    

      expect(page).to have_text("Fang (rank 1)")
    end

    scenario "Lord's Alliance" do
      @faction = FactoryGirl.create(:faction, name: "Lord's Alliance")
      @faction_rank = FactoryGirl.create(:faction_rank, name: "Warduke", numerical_rank: 4, faction: @faction)
      @character.faction = @faction
      @character.character_log_entries = [FactoryGirl.create(:character_log_entry, renown_gained: 50, num_secret_missions: 6, xp_gained: 1000000)]
      @character.save!

      visit user_character_path(@user, @character) 

      expect(page).to have_text("Warduke (rank 4)")
    end
  end
end