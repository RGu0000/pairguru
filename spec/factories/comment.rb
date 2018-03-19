FactoryBot.define do
  factory :comment do
    message { Faker::Lorem.sentence }
    sequence(:author_id) { |n| n }
    sequence(:movie_id) { |n| n }

    trait :from_last_week do
      created_at { Faker::Date.between(6.days.ago, Time.zone.today) }
    end

    trait :older_than_week do
      created_at { Faker::Date.between(1.month.ago, 8.days.ago) }
    end

    trait :author_id_1 do
      author_id 1
    end

    trait :author_id_2 do
      author_id 2
    end

    trait :movie_id_1 do
      movie_id 1
    end

  end
end
