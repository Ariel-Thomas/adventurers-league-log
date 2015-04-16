class AddFactionRankToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :faction_rank, :string
  end
end
