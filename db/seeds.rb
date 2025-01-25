# Create Users
admin = User.find_or_create_by!(username: 'admin', email: 'admin@example.com') do |user|
  user.password = 'password'
  user.roles = [ :admin ]
end

player = User.find_or_create_by!(username: 'player', email: 'player@example.com') do |user|
  user.password = 'password'
  user.roles = [ :player ]
end

# Fetch and create 50 cards
FetchMtgApiCardsJob.perform_now(50)

# Create Decks for admin
2.times do |i|
  deck = Deck.create!(name: "Admin Deck #{i + 1}", user: admin)
  Card.order('RANDOM()').limit(10).each do |card|
    DeckCard.create!(deck: deck, card: card, amount: 2)
  end
  deck.reload
  deck.update_colors!
end

# Create Decks for player
2.times do |i|
  deck = Deck.create!(name: "Player Deck #{i + 1}", user: player)
  Card.order('RANDOM()').limit(10).each do |card|
    DeckCard.create!(deck: deck, card: card, amount: 2)
  end
  deck.reload
  deck.update_colors!
end

# Create comments for Cards
Card.find_each do |card|
  3.times do |i|
    Comment.create!(user: admin, related: card, content: "Comment #{i + 1} on #{card.name}")
  end
end

# Create comments for Decks
Deck.find_each do |deck|
  3.times do |i|
    Comment.create!(user: player, related: deck, content: "Comment #{i + 1} on #{deck.name}")
  end
end
