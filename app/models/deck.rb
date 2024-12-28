class Deck < ApplicationRecord
  include CommonModel
  attr_normalize_string :name
  flag :colors, MTG_COLORS
  belongs_to :user
  has_many :comments, as: :related, dependent: :destroy
  has_many :deck_cards, inverse_of: :deck, dependent: :destroy
  has_many :cards, through: :deck_cards
  accepts_nested_attributes_for :deck_cards, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true
  scope :with_colors, ->(v) { where_colors(*[v].flatten.reject(&:blank?)) }
  scope :with_user_id, ->(v) { where(user_id: v) }

  def self.table_columns
    [:name_with_link, :colors_s, :user_s]
  end

  def self.filters_enabled?
    true
  end

  def colors_s
    colors.map{|c| I18n.t(c, scope: "common.colors_values") }.join(', ')
  end

  def user_s
    user.username.blank? ? user.email : user.username
  end

  def to_s
    name
  end

  def update_colors
    self.colors = cards.pluck(:colors).map{|e| Card.colors.to_array(e)}.flatten.uniq
    self.save
  end

end