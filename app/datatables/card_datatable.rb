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
        name: record.name,
        desc: record.desc,
        colors: record.colors,
        card_type: record.card_type,
        rarity: record.rarity
      }
    end
  end

  def get_raw_records
    Card.all
  end
end
