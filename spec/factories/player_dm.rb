FactoryBot.define do
  factory :player_dm do
    user

    name { Faker::Name.name }
    dci  { Faker::Number.number(digits: 16) }
  end
end
