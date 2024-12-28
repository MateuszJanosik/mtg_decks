# frozen_string_literal: true

class CardsController < ApplicationController
  include CommonController
  
  private

  def safe_params
    params.require(:card).permit(:name, :desc, :colors, :rarity, :card_type, :image, colors: [], rarity: [], card_type: [])
  end
end
