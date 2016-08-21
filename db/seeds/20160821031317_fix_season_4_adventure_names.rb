class FixSeason4AdventureNames < PhilColumns::Seed

  envs :test, :development, :production
  tags :default

  def up
    season4_adventure_changes =
                 {"House of Strahd":         "Curse of Strahd",
                  "DDAL04-03 The Hangman":   "DDAL04-03 The Executioner",
                  "DDAL04-05 The Espers":    "DDAL04-05 The Seer",
                  "DDAL04-09 The Temptress": "DDAL04-09 The Tempter"}

    season4_adventure_changes.each do |original_name, new_name|
      AdventureFormInput.find_by(name: original_name).update!(name: new_name)
    end
  end

  def down
  end
end
