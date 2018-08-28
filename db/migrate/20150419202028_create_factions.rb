class CreateFactions < ActiveRecord::Migration[5.2]
  def change
    create_table :factions do |t|
      t.string :name
      t.string :flag_url
    end

    rename_column :characters, :faction, :faction_override
    add_column :characters, :faction_id, :integer
  end
end
