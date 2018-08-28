class RemoveSeasonOriginOverrideFromCharacters < ActiveRecord::Migration[5.2]
  def change
    remove_column :characters, :season_origin_override, :string
  end
end
