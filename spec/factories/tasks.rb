FactoryGirl.define do
  factory :task do
    description Faker::Lorem.sentence

    trait :complete do
      complete true
    end
  end
end
