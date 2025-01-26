class IndexDatatableComponent < ViewComponent::Base
  attr_reader :resource_class
  renders_one :table, Datatable::TableComponent
  renders_many :filters, Datatable::FilterComponent
end
