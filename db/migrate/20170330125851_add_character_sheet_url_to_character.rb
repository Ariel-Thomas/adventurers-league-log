class AddCharacterSheetUrlToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :character_sheet_url, :string
  end
end
