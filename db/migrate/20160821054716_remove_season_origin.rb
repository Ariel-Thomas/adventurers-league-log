class RemoveSeasonOrigin < ActiveRecord::Migration
  def change
    drop_table :season_origins
    remove_column :characters, :season_origin_id, :string
  end
end
