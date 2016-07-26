class CreateSeasonOrigins < ActiveRecord::Migration
  def change
    create_table :season_origins do |t|
      t.string :name
    end
  end
end
