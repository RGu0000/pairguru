FactoryBot.define do
  factory :movie do
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence(3, true) }
    released_at { Faker::Date.between(40.years.ago, Time.zone.today) }
    genre

    trait :created_21_03_2018 do
      released_at { Date.new(2018,03,21) }
    end
  end
end
