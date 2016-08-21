FactoryGirl.define do
  factory :character_log_entry do
    type { CharacterLogEntry }
    character { FactoryGirl.create :character }

    date_played { Faker::Date.forward(365) }
    adventure_title { "DDAL01-01 The Beginning" }
    session_num { Faker::Number.between(1, 10) }
    xp_gained { Faker::Number.between(200, 10000) }
    gp_gained { Faker::Number.between(200, 10000) }
    renown_gained { 1 }
    downtime_gained { 10 }
    location_played { "GenCon" }
    dm_name { Faker::Name.name}
    dm_dci_number { Faker::Number.number(16) }
    notes { Faker::Company.bs }
    num_secret_missions { Faker::Number.between(0, 1) }
  end
end