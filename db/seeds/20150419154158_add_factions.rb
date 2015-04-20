class AddFactions < PhilColumns::Seed

  envs :test, :development, :production
  tags :default

  def up
    factions = {"Harpers":               "harpers.jpg",
                "Order of the Gauntlet": "orderofthegauntlet.jpg",
                "Emerald Enclave":       "emeraldenclave.jpg",
                "Lord's Alliance":       "lordsalliance.jpg",
                "Zhentarim":             "zhentarim.jpg"               }

    factions.each do |faction, flag_url|
      Faction.create!(name: faction, flag_url: flag_url)
    end
  end

  def down
    Faction.all.delete_all
  end

end
