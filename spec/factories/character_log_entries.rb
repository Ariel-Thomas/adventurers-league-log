FactoryBot.define do
  factory :character_log_entry do
    type { CharacterLogEntry }
    character { FactoryBot.create :character }

    date_played { Faker::Date.forward(days: 365) }
    adventure_title { 'DDAL01-01 The Beginning' }
    session_num { Faker::Number.between(from: 1, to: 10) }
    xp_gained { Faker::Number.between(from: 200, to: 10_000) }
    gp_gained { Faker::Number.between(from: 200, to: 10_000) }
    renown_gained { 1 }
    downtime_gained { 10 }
    location_played { 'GenCon' }
    dm_name { Faker::Name.name }
    dm_dci_number { Faker::Number.number(digits: 16) }
    notes { Faker::Company.bs }
    num_secret_missions { Faker::Number.between(from: 0, to: 1) }
  end
end
