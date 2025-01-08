class DeckCard < ApplicationRecord
  belongs_to :deck
  belongs_to :card

  before_save :cache_card_name

  private

  def cache_card_name
    self.card_name = card.name
  end
end
