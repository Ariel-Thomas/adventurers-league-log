require 'rails_helper'

RSpec.feature 'Character Log Entries', type: :feature do
  before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user, scope: :user)
    @character = FactoryBot.create(:character, user: @user)
    @character_log_entry = FactoryBot.create(:character_log_entry, user: @user)
    @character_log_entry.characters = [@character]
  end

  scenario 'Delete a Character Log Entry' do
    @character_log_entry_count = CharacterLogEntry.count
    visit user_character_path(@user, @character)

    click_link 'Delete'
    # find_link('Delete').trigger('click') # hack to fix previous line

    expect(CharacterLogEntry.count).to be(@character_log_entry_count - 1)

    expect(page).to have_text("Successfully deleted " + @character_log_entry.adventure_title)

    visit user_character_path(@user, @character)

    expect(page).to_not have_text(@character_log_entry.date_played.strftime('%Y-%m-%d %H:%M'))
    expect(page).to_not have_text(@character_log_entry.adventure_title)
    # expect(page).to_not have_text(@character_log_entry.session_num)
    expect(page).to_not have_text(@character_log_entry.xp_gained)
    expect(page).to_not have_text(@character_log_entry.gp_gained.floor)
    expect(page).to_not have_text(@character_log_entry.downtime_gained)
  end
end
