class MtgApi::Response
  attr_reader :response

  def initialize(server_response)
    @response = parse_response(server_response)
  rescue HTTP::Error => e
    handle_http_error(server_response, e)
  end

  def success?
    errors.blank?
  end

  def errors
    response[:error]
  end

  def data(key)
    response[key]
  end

  private

  def parse_response(server_response)
    ActiveSupport::HashWithIndifferentAccess.new(server_response.parse)
  end

  def handle_http_error(server_response, error)
    Rails.logger.error("MTG API error - HTTP::Error", response_status: server_response.status.to_i,
                       response_headers: server_response.headers.to_h, response_body: server_response.to_s)
    raise error
  end
end
