class CardDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    @view_columns ||= {
      name: { source: "Card.name", cond: :like },
      desc: { source: "Card.desc", cond: :like },
      colors: { source: "Card.colors" },
      card_type: { source: "Card.card_type" },
      rarity: { source: "Card.rarity" }
    }
  end

  def data
    records.map do |record|
      {
        name: record.name_with_link,
        desc: truncate_desc(record.desc),
        colors: record.colors_s,
        card_type: record.card_type_s,
        rarity: record.rarity_s
      }
    end
  end

  def get_raw_records
    params[:filters].blank? ? Card.all : filtered_records
  end

  private

  def truncate_desc(desc)
    desc.to_s.truncate(70, separator: " ")
  end

  def filtered_records
    scope = Card.all
    scope = scope.with_colors(filtered_colors) if filtered_colors.presence
    scope = scope.with_rarity(filtered_rarity) if filtered_rarity.presence
    scope = scope.with_card_type(filtered_card_type) if filtered_card_type.presence
    scope
  end

  def filtered_colors
    params.dig(:filters, :with_colors).to_s.split(",")
  end

  def filtered_rarity
    params.dig(:filters, :with_rarity).to_s.split(",")
  end

  def filtered_card_type
    params.dig(:filters, :with_card_type).to_s.split(",")
  end
end
