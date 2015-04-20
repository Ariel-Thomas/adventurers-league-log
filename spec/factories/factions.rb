FactoryGirl.define do
  factory :faction do
    name { 'Harpers' }
    flag_url { Faker::Avatar.image }
  end
end