class AddLifestyles < PhilColumns::Seed

  envs :test, :development, :production
  tags :default

  def up
    lifestyles =   ["Wretched",
                    "Squalid",
                    "Poor",
                    "Modest",
                    "Comfortable",
                     "Wealthy",
                   "Aristocratic"]

    lifestyles.each do |lifestyle|
      Lifestyle.create!(name: lifestyle)
    end
  end

  def down
    Lifestyle.all.delete_all
  end

end
