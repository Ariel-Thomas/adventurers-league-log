require "rails_helper"

RSpec.feature "Add Magic items", :type => :feature, js: true do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user, :scope => :user)
    @character       = FactoryGirl.create(:character, user: @user)
  end

  scenario 'Add log entry with magic item' do
    visit user_character_path(@user, @character)

    click_link 'New Log Entry'

    within('#magic-items-form') do
      fill_in "Name",  :with => "Sword +1"
      # select  "Rare",  :from => "Rarity"
      # fill_in "Notes", :with => "Grants a +1 on all attack and damage rolls"
    end

    click_button 'Save'

    expect(page).to have_text('Log Entries')
    expect(page).to have_text('Sword +1')
  end
end