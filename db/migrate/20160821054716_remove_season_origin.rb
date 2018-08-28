class RemoveSeasonOrigin < ActiveRecord::Migration[5.2]
  def change
    drop_table :season_origins
    remove_column :characters, :season_origin_id, :string
  end
end
