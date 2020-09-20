class AddSeasonAndTagToCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :season, :string, default: ""
    add_column :characters, :tag, :string, default: ""
  end
end
