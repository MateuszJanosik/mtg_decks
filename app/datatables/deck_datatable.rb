class DeckDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    @view_columns ||= {
      name: { source: "Deck.name", cond: :like },
      colors: { source: "Deck.colors"},
      user: { source: "Deck.user_id" },
    }
  end

  def data
    records.map do |record|
      {
        name: record.name_with_link,
        colors: record.colors_s,
        user: record.user.to_s,
      }
    end
  end

  def get_raw_records
    params[:filters].blank? ? Deck.all : filtered_records
  end

  private

  def filtered_records
    scope = Deck.all
    scope = scope.with_colors(filtered_colors) if filtered_colors.presence
    scope = scope.with_user_id(filtered_user) if filtered_user.presence
    scope
  end

  def filtered_colors
    params.dig(:filters, :with_colors).to_a.compact_blank
  end

  def filtered_user
    params.dig(:filters, :with_user_id)
  end
end
