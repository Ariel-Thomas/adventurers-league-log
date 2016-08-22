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

      within all('#magic-items-form .magic-item').last do
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

    context 'existing log entry' do
      before(:each) do
        @log_entry = FactoryGirl.create(:character_log_entry)
        @magic_item = FactoryGirl.create(:magic_item, name: "Staff of Power", log_entry: @log_entry)
        @character.character_log_entries = [@log_entry]
      end

      scenario 'Add to existing log entry with magic item' do
        visit user_character_path(@user, @character)

        #click_link "Edit"
        find_link('Edit').trigger('click') #hack to fix previous line
        click_link 'Add Magic Item'

        within all('#magic-items-form .magic-item').last do
          fill_in "Name",  :with => "Sword +1"
          select  "Legendary",  :from => "Rarity"
          fill_in "Notes", :with => "Grants a +1 on all attack and damage rolls"
        end

        click_button 'Save'

        expect(page).to have_text('Log Entries')

        #click_link "Show"
        find_link('Show').trigger('click') #hack to fix previous line
        expect(page).to have_text(@magic_item.name)
        expect(page).to have_text(@magic_item.rarity.titleize)
        expect(page).to have_text(@magic_item.notes)  

        expect(page).to have_text('Sword +1')
        expect(page).to have_text('Legendary')
        expect(page).to have_text('Grants a +1 on all attack and damage rolls')   
      end

      scenario 'Remove from existing log entry with magic item' do
        visit user_character_path(@user, @character)

        #click_link "Edit"
        find_link('Edit').trigger('click') #hack to fix previous line
        click_link 'Remove'
        click_button 'Save'

        expect(page).to have_text('Log Entries')

        #click_link "Show"
        find_link('Show').trigger('click') #hack to fix previous line
        expect(page).to_not have_text(@magic_item.name)
        expect(page).to_not have_text(@magic_item.rarity.titleize)
        expect(page).to_not have_text(@magic_item.notes)  
      end
    end
  end

  context 'dm log sheet' do
    scenario 'Add log entry with magic item' do
      visit user_dm_log_entries_path(@user)

      click_link 'New Log Entry'
      click_link 'Add Magic Item'

      within all('#magic-items-form .magic-item').last do
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

    context 'existing log entry' do
      before(:each) do
        @log_entry = FactoryGirl.create(:dm_log_entry)
        @magic_item = FactoryGirl.create(:magic_item, name: "Staff of Power", log_entry: @log_entry)
        @user.dm_log_entries = [@log_entry]
      end

      scenario 'Add to existing log entry with magic item' do
        visit user_dm_log_entries_path(@user)

        #click_link 'Edit'
        find_link('Edit').trigger('click') #hack to fix previous line
        click_link 'Add Magic Item'

        within all('#magic-items-form .magic-item').last do
          fill_in "Name",  :with => "Sword +1"
          select  "Legendary",  :from => "Rarity"
          fill_in "Notes", :with => "Grants a +1 on all attack and damage rolls"
        end

        click_button 'Save'

        expect(page).to have_text('Log Entries')

        #click_link "Show"
        find_link('Show').trigger('click') #hack to fix previous line
        expect(page).to have_text(@magic_item.name)
        expect(page).to have_text(@magic_item.rarity.titleize)
        expect(page).to have_text(@magic_item.notes)  

        expect(page).to have_text('Sword +1')
        expect(page).to have_text('Legendary')
        expect(page).to have_text('Grants a +1 on all attack and damage rolls')
      end

      scenario 'Remove from existing log entry with magic item' do
        visit user_dm_log_entries_path(@user, @character)

        #click_link 'Edit'
        find_link('Edit').trigger('click') #hack to fix previous line

        click_link 'Remove'
        click_button 'Save'

        expect(page).to have_text('Log Entries')

        #click_link "Show"
        find_link('Show').trigger('click') #hack to fix previous line
        expect(page).to_not have_text(@magic_item.name)
        expect(page).to_not have_text(@magic_item.rarity.titleize)
        expect(page).to_not have_text(@magic_item.notes)  
      end      
    end
  end
end