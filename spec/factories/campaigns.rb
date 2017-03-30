FactoryGirl.define do
  factory :campaign do
    users { [FactoryGirl.create(:user)] }

    name { "Storm King's Thunder Table" }
    users_can_join   { true }
    dms_can_join     { true }
    publicly_visible { true }
  end
end
