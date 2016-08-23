FactoryGirl.define do
  factory :magic_item do
    log_entry  { FactoryGirl.create :character_log_entry }

    name       { 'Staff of Wonder' }
    rarity     { 'uncommon' }
    notes      { Faker::Company.bs }
  end
end
