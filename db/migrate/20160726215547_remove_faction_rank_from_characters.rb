class RemoveFactionRankFromCharacters < ActiveRecord::Migration[5.2]
  def change
    remove_column :characters, :faction_rank, :string
  end
end
