FactoryBot.define do
  factory :magic_item do
    log_entry { FactoryBot.create :character_log_entry }

    name           { 'Staff of Wonder' }
    rarity         { 'uncommon' }
    location_found { "Guh's butt" }
    table          { 'F' }
    table_result   { '55' }

    notes          { Faker::Company.bs }

    after(:create) do |magic_item|
      magic_item.character = magic_item.log_entry.character
      magic_item.character = FactoryBot.create(:character) unless magic_item.character
      magic_item.save!
    end
  end
end
