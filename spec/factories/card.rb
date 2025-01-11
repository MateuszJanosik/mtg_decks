FactoryBot.define do
  factory :card do
    name { "Test Card" }
    desc { "This is a test card." }
    rarity { "common" }
    card_type { "creature" }
    colors { [] }
  end
end
