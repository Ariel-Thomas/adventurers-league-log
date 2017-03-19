FactoryGirl.define do
  factory :player_dm do
    user

    name { Faker::Name.name }
    dci  { Faker::Number.number(16) }
  end
end
