FactoryBot.define do
  factory :campaign do
    users { [FactoryBot.create(:user)] }

    name { "Storm King's Thunder Table" }
    users_can_join   { true }
    dms_can_join     { true }
    publicly_visible { true }
  end
end
