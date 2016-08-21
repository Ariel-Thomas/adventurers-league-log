class RemoveSeasonOriginOverrideFromCharacters < ActiveRecord::Migration
  def change
    remove_column :characters, :season_origin_override, :string
  end
end
