FactoryBot.define do
  factory :comment do
    message { Faker::Lorem.sentence(1, true) }
    sequence(:author_id) { |n| n }
    sequence(:movie_id) { |n| n }

    trait :from_last_week do
      created_at { Faker::Date.between(6.days.ago, Time.zone.today) }
    end

    trait :from_last_month do
      created_at { Faker::Date.between(1.month.ago, Time.zone.today) }
    end
  end
end
