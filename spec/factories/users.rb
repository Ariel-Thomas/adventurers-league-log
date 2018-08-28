FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }

    autocalc_default { true }

    character_style :old
    character_log_entry_style :old
    magic_item_style :old
    dm_style :old
    dm_log_entry_style :old
  end
end
