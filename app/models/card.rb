class Card < ApplicationRecord
  include CommonModel
  mount_uploader :image, ImageUploader
  flag :colors, MTG_COLORS
  enum rarity: [ :common, :uncommon, :rare, :mythic ]
  enum card_type: {
    artifact: 0, conspiracy: 1, creature: 2, enchantment: 3, instant: 4, land: 5,
    phenomenon: 6, plane: 7, planeswalker: 8, scheme: 9, sorcery: 10, tribal: 11, vanguard: 12
  }
  validates :name, :rarity, :card_type, presence: true
  has_many :deck_cards
  has_many :decks, through: :deck_cards, dependent: :destroy
  has_many :comments, as: :related, dependent: :destroy
  after_save :update_card_decks
  after_save :update_decks
  attr_normalize_string :name

  scope :with_colors, ->(v) { where_colors(*[ v ].flatten.reject(&:blank?)) }
  scope :with_rarity, ->(v) { where(rarity: [ v ].flatten.reject(&:blank?)) }
  scope :with_card_type, ->(v) { where(card_type: [ v ].flatten.reject(&:blank?)) }

  def self.index_column_names
    [ :name, :desc, :colors, :card_type, :rarity ]
  end

  def colors_s
    colors.map { |c| I18n.t(c, scope: "common.colors_values") }.join(", ")
  end

  def rarity_s
    self.class.human_enum_name(:rarity, rarity)
  end

  def card_type_s
    self.class.human_enum_name(:card_type, card_type)
  end

  def to_s
    name
  end

  def update_card_decks
    deck_cards.update_all(card_name: name) if previous_changes.include?(:name)
  end

  def update_decks
    decks.each(&:update_colors!) if previous_changes.include?(:colors)
  end
end
