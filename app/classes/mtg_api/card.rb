class MtgApi::Card
  include MtgApi::Requester

  TABLE_NAME = "cards"

  attr_reader :params

  class << self
    def find(id)
      response = get(id)
      response.success? ? new(response.data(:card)) : nil
    end

    def search_cards(params)
      response = search(params)
      response.success? ? response.data(:cards).map { |card_data| new(card_data) } : []
    end

    def fetch_cards(limit)
      cards = []
      page = 1
      while cards.size < limit
        response = search(page: page)
        break unless response.success?
        cards.concat(response.data(:cards).map { |card_data| new(card_data) })
        break if response.data(:cards).size < 100

        page += 1
      end
      cards.take(limit)
    end
  end

  def initialize(params)
    @params = params
  end

  def id
    @params["id"]
  end

  def name
    @params["name"]
  end

  def colors
    @params["colors"]
  end

  def card_type
    @params["type"]
  end

  def rarity
    @params["rarity"]
  end

  def image
    @params["imageUrl"]
  end

  def description
    @params["text"]
  end
end
