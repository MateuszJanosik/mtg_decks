FactoryBot.define do
  factory :deck do
    sequence(:name) { |n| "Test Deck #{n}" }
    user

    after(:create) do |deck|
      create_list(:deck_card, 3, deck: deck)
    end
  end
end
