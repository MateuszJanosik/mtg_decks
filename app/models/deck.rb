class Deck < ApplicationRecord
  include CommonModel
  attr_normalize_string :name
  flag :colors, MTG_COLORS
  belongs_to :user
  has_many :comments, as: :related, dependent: :destroy
  has_many :deck_cards, inverse_of: :deck, dependent: :destroy
  has_many :cards, through: :deck_cards
  accepts_nested_attributes_for :deck_cards, reject_if: :all_blank, allow_destroy: true
  before_save :merge_duplicate_deck_cards
  before_save :recalculate_colors

  validates :name, presence: true
  scope :with_colors, ->(v) { where_colors(*[ v ].flatten.reject(&:blank?)) }
  scope :with_user_id, ->(v) { where(user_id: v) }

  def self.index_column_names
    [ :name, :colors, :user ]
  end

  def self.filters_enabled?
    true
  end

  def colors_s
    colors.map { |c| I18n.t(c, scope: "common.colors_values") }.join(", ")
  end

  def user_s
    user.username.blank? ? user.email : user.username
  end

  def to_s
    name
  end

  def update_colors!
    recalculate_colors
    save!
  end

  private

  def recalculate_colors
    self.colors = deck_cards.reject(&:marked_for_destruction?).map { |e| e.card.colors.to_a }.flatten.uniq
  end

  def merge_duplicate_deck_cards
    grouped_cards = deck_cards.group_by(&:card_id)
    grouped_cards.each do |card_id, cards|
      if cards.size > 1
        cards.first.amount = cards.sum(&:amount)
        cards.drop(1).each(&:mark_for_destruction)
      end
    end
  end
end
