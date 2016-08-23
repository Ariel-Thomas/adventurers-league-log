FactoryGirl.define do
  factory :faction_rank do
    faction        { FactoryGirl.create :faction }

    name           { 'High Harper' }
    numerical_rank { 5 }
  end
end
