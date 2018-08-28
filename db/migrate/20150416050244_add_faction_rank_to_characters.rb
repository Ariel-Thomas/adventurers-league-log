class AddFactionRankToCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :faction_rank, :string
  end
end
