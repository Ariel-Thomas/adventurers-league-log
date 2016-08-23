class AddPositionNumToFormInputs < PhilColumns::Seed
  envs :test, :development, :production
  tags :default

  def up
    AdventureFormInput.all.each_with_index do |form_input, index|
      form_input.update!(position_num: (index + 1) * 10)
    end
  end

  def down
  end
end
