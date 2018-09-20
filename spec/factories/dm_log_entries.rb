FactoryBot.define do
  factory :dm_log_entry do
    type { DmLogEntry }
    user { FactoryBot.create :user }

    date_dmed       { Faker::Date.forward(365) }
    date_played     { Faker::Date.forward(366) }
    adventure_title { 'DDAL01-01 The Beginning' }
    session_num     { Faker::Number.between(100, 10_000) }
    xp_gained       { Faker::Number.between(200, 10_000) }
    gp_gained       { Faker::Number.between(200, 10_000) }
    downtime_gained { 10 }
    renown_gained   { 1 }
    location_played { 'GenCon' }
    notes           { Faker::Company.bs }
  end
end
