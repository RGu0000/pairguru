FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Name - #{n}" }
    sequence(:email) { |n| "email-#{n}@gmail.com" }
    confirmed_at { Faker::Date.between(6.weeks.ago, Time.zone.today) }
    password '11111111'

    trait :with_15_comments_last_week do
      after(:create) do |user|
        create_list :comment, 15, :from_last_week, user: user
      end
    end

    trait :with_10_comments_last_week do
      after(:create) do |user|
        create_list :comment, 10, :from_last_week, user: user
      end
    end

    trait :with_1_comment_last_week do
      after(:create) do |user|
        create :comment, :from_last_week, user: user
      end
    end

    trait :with_5_comments_last_week do
      after(:create) do |user|
        create_list :comment, 5, :from_last_week, user: user
      end
    end

    trait :with_5_comments_older_than_week do
      after(:create) do |user|
        create_list :comment, 5, :older_than_week, user: user
      end
    end

    trait :user_id_1 do
      id 1
    end
  end
end
