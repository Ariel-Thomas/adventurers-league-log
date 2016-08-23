class FixPositionNumForAdventures < PhilColumns::Seed
  envs :test, :development, :production
  tags :default

  def up
    AdventureFormInput.order(:id).all.each_with_index do |form_input, index|
      form_input.update!(position_num: (index + 1) * 10)
    end

    AdventureFormInput.find_by(name: 'Dungeon Master Quest').update(position_num: 1)
  end

  def down
  end
end
