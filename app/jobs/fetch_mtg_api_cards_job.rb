class FetchMtgApiCardsJob < ApplicationJob
  require "open-uri"

  def perform(sample_size = nil)
    cards = MtgApi::Card.fetch_cards(350, set: "SOI")
    cards = cards.sample(sample_size.to_i) if sample_size
    cards.each { |card_data| create_card_from_api_data(card_data) }
  end

  private

  def create_card_from_api_data(api_data)
    return if Card.exists?(external_id: api_data.id)

    card = Card.new(
      name: api_data.name,
      desc: api_data.description,
      colors: map_colors(api_data.colors),
      card_type: map_card_type(api_data.card_types),
      rarity: map_rarity(api_data.rarity),
      external_id: api_data.id
    )
    card.image = download_image(api_data.image)
    card.save!
  end

  def map_colors(colors)
    return [] if colors.blank?

    color_map = { "R" => "red", "G" => "green", "B" => "black", "U" => "blue", "W" => "white" }
    colors.map { |color| color.length == 1 ? color_map[color] : color.downcase }
  end

  def map_card_type(card_types)
    card_types.first.downcase
  end

  def map_rarity(rarity)
    rarity.downcase if Card.rarities.keys.include?(rarity.downcase)
  end

  def download_image(image_url)
    return unless image_url

    file = URI.open(image_url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE)
    filename = "card_#{SecureRandom.uuid}.jpg"
    File.open(Rails.root.join("public", "uploads", filename), "wb") { |f| f.write(file.read) }
    File.open(Rails.root.join("public", "uploads", filename))
  end
end
