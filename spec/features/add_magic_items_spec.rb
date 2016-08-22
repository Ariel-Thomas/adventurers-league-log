require "rails_helper"

RSpec.feature "Add Magic items", :type => :feature, js: true do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user, :scope => :user)
    @character       = FactoryGirl.create(:character, user: @user)
  end

  context 'character log sheet' do
    scenario 'Add log entry with magic item' do
      visit user_character_path(@user, @character)

      click_link 'New Log Entry'
      click_link 'Add Magic Item'

      within('#magic-items-form') do
        fill_in "Name",  :with => "Sword +1"
        select  "Rare",  :from => "Rarity"
        fill_in "Notes", :with => "Grants a +1 on all attack and damage rolls"
      end

      click_button 'Save'

      expect(page).to have_text('Log Entries')

      #click_link "Show"
      find_link('Show').trigger('click') #hack to fix previous line
      expect(page).to have_text('Sword +1')
      expect(page).to have_text('Rarity')
      expect(page).to have_text('Grants a +1 on all attack and damage rolls')    
    end
  end

  context 'dm log sheet' do
    scenario 'Add log entry with magic item' do
      visit user_dm_log_entries_path(@user)

      click_link 'New Log Entry'
      click_link 'Add Magic Item'

      within('#magic-items-form') do
        fill_in "Name",  :with => "Sword +1"
        select  "Rare",  :from => "Rarity"
        fill_in "Notes", :with => "Grants a +1 on all attack and damage rolls"
      end

      click_button 'Save'

      expect(page).to have_text('DM Log Entries')

      #click_link "Show"
      find_link('Show').trigger('click') #hack to fix previous line
      expect(page).to have_text('Sword +1')
      expect(page).to have_text('Rarity')
      expect(page).to have_text('Grants a +1 on all attack and damage rolls')
    end
  end
end