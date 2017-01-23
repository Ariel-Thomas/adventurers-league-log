class AddSeason5CccAdventures < PhilColumns::Seed
  envs :test, :development, :production
  tags :default

  def up
    season5_ccc_adventures =
      [ 'CIC-01  The Vault of the Devourer',
        'CORE1-1 A Scream in the Night',
        'CORE1-2 A Cog in the Wheel',
        'CORE1-3 A Hole in the World',
        'CORE2-1 Tales of Good and Evil',
        'CORE2-2 Songs of Law & Chaos',
        'CORE2-3 Edicts of Neutrality',
        'ELM1-1  The Sage of Cormathor',
        'GHC-01  Tharaera Lost',
        'GHC-02  Skulljaw Hill',
        'GHC-03  Facing the Dark',
        'HILL1-1 Arrival',
        'HILL1-2 Exodus',
        'HILL1-3 Resurgance',
        'HULB1-1 Hulburg Rebuilding',
        'HULB1-2 Hulburg Burning',
        'HULB1-3 Hulburg Rising',
        'PHLAN1-1  Sepulture',
        'PHLAN1-2  Enemy of my Enemy',
        'PHLAN1-3  Subterfuge',
        'UCON-01 Blood and Fog',
        'DDAL00-01 Window to the Past'
        ]

    season5_ccc_adventures.each do |adventure|
      Adventure.find_or_create_by(name: adventure)
    end
  end

  def down
  end
end