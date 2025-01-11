FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "testuser#{n}" }
    sequence(:email) { |n| "testuser#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }

    trait :admin do
      username { "adminuser" }
      email { "admin@example.com" }
      roles { [ "admin" ] }
    end

    trait :player do
      username { "playeruser" }
      email { "player@example.com" }
      roles { [ "player" ] }
    end
  end
end
