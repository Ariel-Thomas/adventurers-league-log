class CreateSeasonOrigins < ActiveRecord::Migration[5.2]
  def change
    create_table :season_origins do |t|
      t.string :name
    end
  end
end
