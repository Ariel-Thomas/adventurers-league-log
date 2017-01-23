class AddSeason5Part2Adventures < PhilColumns::Seed
  envs :test, :development, :production
  tags :default

  def up
    season5_adventures =
      [ 'DDAL05-11 Forgotten Tradition',
        'DDAL05-12 Bad Business in Parnast',
        'DDAL05-13 Jarl Rising',
        'DDAL05-14 Reeducation',
        'DDAL05-15 Reeducation Part 2',
        'DDAL05-16 Parnast Under Siege',
        "DDAL05-17 Hartkiller's Horn",
        'DDAL05-18 Eye of Xxiphu Part 1',
        'DDAL05-19 Eye of Xxiphu Part 2']

    season5_adventures.each do |adventure|
      Adventure.find_or_create_by(name: adventure)
    end

    season5_adventure_changes =
                 {"DDAL05-08 Beneath Durlag’s Tower":       "DDAL05-08 Durlag’s Tower",
                  "DDAL05-09 Beneath Durlag’s Tower pt2":   "DDAL05-09 Durlag's Tomb"}

    season5_adventure_changes.each do |original_name, new_name|
      Adventure.where(name: original_name).update_all(name: new_name)
    end

    season5_adventure_changes.each do |original_name, new_name|
      LogEntry.where(adventure_title: original_name).update_all(adventure_title: new_name)
    end
  end

  def down
  end
end
