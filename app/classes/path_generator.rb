class PathGenerator
  def initialize(record, options = {})
    @record = record
    @options = options
  end

  def path
    raise ActionController::UrlGenerationError if @record.blank?

    segments = build_segments
    address = build_address(segments)
    format_address(address)
  end

  private

  def build_segments
    action = @options.delete(:action)
    segments = if @record.is_a?(Class)
                 plural_name_for(@record)
    elsif @record.persisted?
                 [ plural_name_for(@record), @record.to_param ]
    else
                 record_plural_name(@record)
    end
    segments = [ segments ].flatten
    segments << action
    segments.compact
  end

  def build_address(segments)
    ("/" + segments.join("/")).gsub("//", "/")
  end

  def format_address(address)
    format = @options.delete(:format)
    address = address.chomp("/") if address.ends_with?("/")
    address << ".#{format}" if format.present?
    [ address, @options.to_query ].reject(&:blank?).join("?")
  end

  def plural_name_for(record)
    return "" if record.nil?
    record_class = record.is_a?(Class) ? record : record.class
    record_class.model_name.route_key
  end
end
