class AddSeasonOrigins < PhilColumns::Seed

  envs :test, :development, :production
  tags :default

  def up
    seasons =  ["Tyranny of Dragons",
                "Elemental Evil",
                "Rage of Demons",
                "Curse of Strahd",
                "Storm King's Thunder"]

    seasons.each do |season|
      SeasonOrigin.create!(name: season)
    end
  end

  def down
    SeasonOrigin.all.delete_all
  end

end
