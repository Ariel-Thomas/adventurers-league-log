class RemoveFactionRankFromCharacters < ActiveRecord::Migration
  def change
    remove_column :characters, :faction_rank, :string
  end
end
