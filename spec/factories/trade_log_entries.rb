FactoryBot.define do
  factory :trade_log_entry do
    type { TradeLogEntry }
    character { FactoryBot.create :character }

    date_played { Faker::Date.forward(365) }
    downtime_gained { -15 }
    notes { Faker::Company.bs }
  end
end
