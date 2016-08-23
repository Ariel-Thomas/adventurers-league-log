class AddAdventureFormInputs < PhilColumns::Seed
  envs :test, :development, :production
  tags :default

  def up
    season1_adventures =
      ['Lost Mine of Phandelver',
       'Hoard of the Dragon Queen',
       'The Rise of Tiamat',
       'DDEN01 Hoard of the Dragon Queen',
       'DDEP01 Corruption in Kryptgarden',
       'DDEX1-01 Defiance in Phlan',
       'DDEX1-02 Secrets of Sokol Keep',
       'DDEX1-03 Shadow on the Moonsea',
       'DDEX1-04 Dues for the Dead',
       'DDEX1-05 The Courting of Fire',
       'DDEX1-06 The Scroll Thief',
       'DDEX1-07 Drums in the Marsh',
       'DDEX1-08 Tales Trees Tell',
       'DDEX1-09 Outlaws of the Iron Route',
       'DDEX1-10 Tyranny in Phlan',
       'DDEX1-11 Dark Pyramid of Sorcerer’s Isle',
       'DDEX1-12 Raiders of the Twilight Marsh',
       'DDEX1-13 Pool of Radiance Resurgent',
       'DDEX1-14 Escape from Phlan']

    season1_adventures.each do |adventure|
      AdventureFormInput.create!(name: adventure)
    end

    season2_adventures =
      ['Princes of the Apocalypse',
       'DDEN02 Princes of the Apocalypse',
       'DDEP02 Mulmaster Undone',
       'DDEX2-01 City of Danger',
       'DDEX2-02 Embers of Elmwood',
       'DDEX2-03 The Drowned Tower',
       'DDEX2-04 Mayhem in the Earthspur Mines',
       'DDEX2-05 Flames of Kythorn',
       'DDEX2-06 Breath of the Yellow Rose',
       'DDEX2-07 Bounty in the Bog',
       'DDEX2-08 Foulness Beneath Mulmaster',
       'DDEX2-09 Eye of the Tempest',
       'DDEX2-10 Cloaks and Shadows',
       'DDEX2-11 Oubliette of Fort Iron',
       'DDEX2-12 Dark Rites at Fort Dalton',
       'DDEX2-13 The Howling Void',
       'DDEX2-14 The Sword of Selfaril',
       'DDEX2-15 Black Heart of Vengeance',
       "DDEX2-16 Boltsmelter's Book"]

    season2_adventures.each do |adventure|
      AdventureFormInput.create!(name: adventure)
    end
  end

  def down
    FormInputs.all.delete_all
  end
end
