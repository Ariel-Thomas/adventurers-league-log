class AddSeasonOriginToCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :season_origin_id, :integer
    add_column :characters, :season_origin_override, :string
  end
end
