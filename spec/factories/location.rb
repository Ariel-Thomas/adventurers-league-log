FactoryGirl.define do
  factory :location do
    user

    name { Faker::Name.name }
  end
end
