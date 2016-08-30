FactoryGirl.define do
  factory :campaign do
    user

    name { "Storm King's Thunder Table" }
    users_can_join   { true }
    publicly_visible { true }
  end
end
