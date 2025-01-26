module Datatable
  class TableComponent < ViewComponent::Base
    include ApplicationHelper

    attr_reader :resource_class, :filters

    def initialize(resource_class:, filters: {})
      @resource_class = resource_class
      @filters = filters
    end
  end
end
