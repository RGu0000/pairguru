FactoryBot.define do
  factory :comment do
    message { Faker::Lorem.sentence(1, true) }
    author_id { Faker::Number.between(1, 20) }
    movie_id { Faker::Number.between(1, 20) }
    created_at { Faker::Date.between(6.weeks.ago, Time.zone.today) }
  end
end
