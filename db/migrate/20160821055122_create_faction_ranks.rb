class CreateFactionRanks < ActiveRecord::Migration[5.2]
  def change
    create_table :faction_ranks do |t|
      t.string  :name
      t.integer :numerical_rank
      t.integer :faction_id
    end
  end
end
