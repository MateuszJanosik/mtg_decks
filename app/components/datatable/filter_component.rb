module Datatable
  class FilterComponent < ViewComponent::Base
    attr_reader :name, :collection, :multiple, :resource_class
    def initialize(name:, collection:, multiple: false, resource_class:)
      @name = name
      @collection = collection
      @multiple = multiple
      @resource_class = resource_class
    end
  end
end
