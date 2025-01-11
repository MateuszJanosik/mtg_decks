
FactoryBot.define do
  factory :deck_card do
    deck
    card
    amount { 1 }
  end
end
