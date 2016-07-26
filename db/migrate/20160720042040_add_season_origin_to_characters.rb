class AddSeasonOriginToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :season_origin_id, :integer
    add_column :characters, :season_origin_override, :string
  end
end
