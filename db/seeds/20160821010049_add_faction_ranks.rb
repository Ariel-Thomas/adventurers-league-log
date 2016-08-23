class AddFactionRanks < PhilColumns::Seed
  envs :test, :development, :production
  tags :default

  def up
    harper_ranks = ['Watcher',
                    'Harpshadow',
                    'Brightcandle',
                    'Wise Owl',
                    'High Harper']

    order_ranks =  ['Chevall',
                    'Marcheon',
                    'Whitehawk',
                    'Vindicator',
                    'Righteous Hand']

    enclave_ranks = ['Springwarden',
                     'Summerstrider',
                     'Autumnreaver',
                     'Winterstalker',
                     'Master of the Wild']

    lords_ranks =  %w(Cloak
                      Redknife
                      Stingblade
                      Warduke
                      Lioncrown)

    zhent_ranks =  ['Fang',
                    'Wolf',
                    'Vipe',
                    'Ardragon',
                    'Dread Lord']

    add_faction_ranks 'Harpers', harper_ranks
    add_faction_ranks 'Order of the Gauntlet', order_ranks
    add_faction_ranks 'Emerald Enclave', enclave_ranks
    add_faction_ranks "Lord's Alliance", lords_ranks
    add_faction_ranks 'Zhentarim', zhent_ranks
  end

  def down
    FactionRank.all.delete_all
  end

  def add_faction_ranks(faction_name, rank_ary)
    rank_ary.each_with_index do |rank_name, index|
      FactionRank.create!(faction: Faction.find_by(name: faction_name), name: rank_name, numerical_rank: index + 1)
    end
  end
end
