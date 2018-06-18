class AddDungeonMasterQuestAdventure < PhilColumns::Seed
  envs :test, :development, :production
  tags :default


  def up
    Adventure.create!(name: 'Dungeon Master Quest', position_num: 0)
  end

  def down
  end

end
