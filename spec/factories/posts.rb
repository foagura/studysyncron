FactoryBot.define do
  factory :post do
    start_time {Time.now}
    study_hours {rand(1..23)}
    study_minutes {rand(0..59)}
    title {Faker::Lorem.word}
    content {Faker::Lorem.sentence}

    association :user
  end
end
