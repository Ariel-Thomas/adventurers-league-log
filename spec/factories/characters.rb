FactoryBot.define do
  factory :character do
    user

    name { Faker::Name.name }
    race { 'High Elf' }
    class_and_levels { 'Wizard 9' }
    # portrait_url { Faker::Avatar.image }
    background { 'Sage' }
    lifestyle { FactoryBot.create :lifestyle }
    faction { FactoryBot.create :faction }
  end
end
