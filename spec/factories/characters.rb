FactoryGirl.define do
  factory :character do
    name { Faker::Name.name }
    season_origin { FactoryGirl.create :season_origin }
    race { "High Elf" }
    class_and_levels { "Wizard 9" }
    portrait_url { Faker::Avatar.image }
    background { "Sage" }
    lifestyle { FactoryGirl.create :lifestyle }
    faction { FactoryGirl.create :faction }
  end
end