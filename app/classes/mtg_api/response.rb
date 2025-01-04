class MtgApi::Response
  attr_reader :response

  def initialize(server_response)
    @response = ActiveSupport::HashWithIndifferentAccess.new server_response.parse
  rescue HTTP::Error
    Rollbar.info("MTG API error - HTTP::Error", response_status: server_response.status.to_i,
                  response_headers: server_response.headers.to_h, response_body: server_response.to_s)
    raise
  end

  def success?
    response[:Success].present?
  end

  def errors
    response[:Errors]
  end
end
