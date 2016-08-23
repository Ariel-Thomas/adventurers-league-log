class AddDungeonMasterQuestAdventure < PhilColumns::Seed
  envs :test, :development, :production
  tags :default

  def up
    AdventureFormInput.find_or_create_by(name: 'Dungeon Master Quest', position_num: 1)
  end

  def down
  end
end
