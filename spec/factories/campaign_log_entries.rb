FactoryBot.define do
  factory :campaign_log_entry do
    type { CampaignLogEntry }

    date_played { Faker::Date.forward(days: 365) }
    adventure_title { 'DDAL01-01 The Beginning' }
    session_num { Faker::Number.between(from: 1000, to: 10_000) }
    xp_gained { Faker::Number.between(from: 2000, to: 10_000) }
    gp_gained { Faker::Number.between(from: 2000, to: 10_000) }
    renown_gained { 1 }
    downtime_gained { Faker::Number.between(from: 2000, to: 10_000) }
    location_played { 'GenCon' }
    dm_name { Faker::Name.name }
    dm_dci_number { Faker::Number.number(digits: 16) }
    notes { Faker::Company.bs }
    num_secret_missions { Faker::Number.between(from: 0, to: 1) }
  end
end
