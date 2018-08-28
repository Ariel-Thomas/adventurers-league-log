class AddDefaultFactionRanks < PhilColumns::Seed
  envs :test, :development, :production
  tags :default


  def up
    default_ranks = ['Novice',
                     'Notorious',
                     'Seasoned',
                     'Heroic',
                     'Paragon']
    Faction.create!(name: "Default", flag_url: "")
    add_faction_ranks('Default', default_ranks)
  end

  def down
  end

  def add_faction_ranks(faction_name, rank_ary)
    rank_ary.each_with_index do |rank_name, index|
      FactionRank.create!(faction: Faction.find_by(name: faction_name), name: rank_name, numerical_rank: index + 1)
    end
  end
end
