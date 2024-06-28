FactoryBot.define do
  factory :user do
    nickname {Faker::Name.name}
    email {Faker::Internet.unique.email}
    password {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    profile {Faker::Lorem.sentence}

    after(:build) do |user|
      user.image.attach(io: File.open('public/images/test.jpg'), filename: 'test.jpg')
    end
  end
end
