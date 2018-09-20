FactoryBot.define do
  factory :faction_rank do
    faction        { FactoryBot.create :faction }

    name           { 'High Harper' }
    numerical_rank { 5 }
  end
end
