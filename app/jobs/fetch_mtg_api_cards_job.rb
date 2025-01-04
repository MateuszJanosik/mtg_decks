class FetchMtgApiCardsJob < ApplicationJob
  require "open-uri"

  def perform
    cards = MtgApi::Card.fetch_cards(50)
    cards.each do |card_data|
      create_card_from_api_data(card_data)
    end
  end

  private

  def create_card_from_api_data(api_data)
    card = Card.new(
      name: api_data.name,
      desc: api_data.description,
      colors: map_colors(api_data.colors),
      card_type: map_card_type(api_data.card_type),
      rarity: map_rarity(api_data.rarity)
    )
    card.image = download_image(api_data.image)
    card.save
  end

  def map_colors(colors)
    return [] if colors.blank?

    color_map = { "R" => "red", "G" => "green", "B" => "black", "U" => "blue", "W" => "white" }
    colors.map do |color|
      if color.length == 1
        color_map[color]
      else
        color.downcase
      end
    end
  end

  def map_card_type(card_type)
    card_type.downcase
  end

  def map_rarity(rarity)
    rarity.downcase if Card.rarities.keys.include?(rarity.downcase)
  end

  def download_image(image_url)
    return unless image_url

    file = URI.open(image_url)
    filename = File.basename(URI.parse(image_url).path)
    { io: file, filename: filename }
  end
end
