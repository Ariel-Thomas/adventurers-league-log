class AddSeason3Adventures < PhilColumns::Seed
  envs :test, :development, :production
  tags :default

  def up
    season3_adventures =
      ['Out of the Abyss',
       'DDEN03 Out of the Abyss',
       'DDEP03 Blood Above, Blood Below',
       'DDEX03-01 Harried in Hillsfar',
       'DDEX03-02 Shackles of Blood',
       'DDEX03-03 The Occupation of Szith Morcane',
       "DDEX03-04 It's all in the Blood",
       'DDEX03-05 Bane of the Tradeways',
       'DDEX03-06 No Foolish Matter',
       'DDEX03-07 Herald of the Moon',
       'DDEX03-08 The Malady of Elventree',
       'DDEX03-09 The Waydown',
       'DDEX03-10 Quelling the Horde',
       'DDEX03-11 The Quest for Sporedome',
       'DDEX03-12 Hillsfar Reclaimed',
       'DDEX03-13 Writhing in the Dark',
       'DDEX03-14 Death on the Wall',
       'DDEX03-15 Szith Morcane Unbound',
       'DDEX03-16 Assault on Maerimydra']

    season3_adventures.each do |adventure|
      AdventureFormInput.find_or_create_by(name: adventure)
    end
  end

  def down
  end
end
