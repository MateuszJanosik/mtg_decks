class PathGenerator
  def self.path_for(record, options = {})
    raise ActionController::UrlGenerationError  if record.blank?
    action = options.delete :action
    format = options.delete :format
    segments = record.is_a?(Class) ? plural_name_for(record) : (record.persisted? ? [plural_name_for(record), record.to_param] : record_plural_name(record))
    segments = [segments].flatten
    segments << action
    segments.compact!
    address = ('/' + segments.join('/')).gsub('//','/')
    if format.present?
      address = address[0..-1] if address.ends_with?('/')
      address << '.' << format.to_s
    end
    full_address = [address, options.to_query].reject(&:blank?).join('?')
    full_address
  end

  def self.plural_name_for(record)
    return '' if record.nil?
    record_class = record.is_a?(Class) ? record : record.class
    record.model_name.route_key
  end
end
