class AddSeason4Adventures < PhilColumns::Seed
  envs :test, :development, :production
  tags :default

  def up
    season4_adventures =
      ['House of Strahd',
       'DDLE04 Death House',
       'DDEP04 Reclamation of Phlan',
       'DDAL04-01 Suits of the Mists',
       'DDAL04-02 The Beast',
       'DDAL04-03 The Hangman',
       'DDAL04-04 The Marionette',
       'DDAL04-05 The Espers',
       'DDAL04-06 The Ghost',
       'DDAL04-07 The Innocent',
       'DDAL04-08 The Broken One',
       'DDAL04-09 The Temptress',
       'DDAL04-10 The Artifact',
       'DDAL04-11 The Donjon',
       'DDAL04-12 The Raven',
       'DDAL04-13 The Horseman',
       'DDAL04-14 The Dark Lord']

    season4_adventures.each do |adventure|
      AdventureFormInput.find_or_create_by(name: adventure)
    end
  end

  def down
  end
end
