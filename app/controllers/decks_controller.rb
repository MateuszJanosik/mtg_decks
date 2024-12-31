# frozen_string_literal: true

class DecksController < ApplicationController
  include CommonController

  def render_datatable
    render json: DeckDatatable.new(params)
  end

  private

  def callback_before_create
    @resource.user = current_user
  end

  def callback_after_create
    @resource.update_colors
  end
  
  def callback_after_update
    @resource.update_colors
  end

  def callback_during_show
    @cards_by_type = @resource.deck_cards.includes(:card).group_by{|e| e.card.card_type}
  end

  def safe_params
    params.require(:deck).permit(:name, :user_id, :colors, :amount, colors: [], deck_cards_attributes: [:id, :card_id, :amount, :_destroy])
  end

end
