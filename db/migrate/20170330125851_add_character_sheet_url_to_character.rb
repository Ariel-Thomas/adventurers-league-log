class AddCharacterSheetUrlToCharacter < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :character_sheet_url, :string
  end
end
