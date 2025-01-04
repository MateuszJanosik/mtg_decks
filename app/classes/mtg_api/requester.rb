module MtgApi::Requester
  extend ActiveSupport::Concern

  API_ADDRESS = "https://api.magicthegathering.io/v1/"

  class_methods do
    def get(id)
      MtgApi::Response.new http_request.get("#{table_address}/#{id}")
    end

    def search(params)
      MtgApi::Response.new http_request.get(table_address, params: params)
    end

    def table_address
      "#{API_ADDRESS}#{self::TABLE_NAME}"
    end

    def http_request
      HTTP.headers(content_type: "application/json", accept: "application/json")
    end
  end
end
