module CommonModel
  extend ActiveSupport::Concern

  module ClassMethods
    def process_attr(*args)
      args.flatten!
      attr_fields = args.reject { |e| e.is_a?(Proc) }
      attr_proc = args.select { |e| e.is_a?(Proc) }.first

      attr_fields.each do |f|
        define_method("#{f}=") do |v|
          super(attr_proc.call(v))
        end
      end
    end

    def attr_normalize_string(*fields)
      fields << ->(e) { e.try(:to_s).try(:squeeze, " ").try(:strip) }
      process_attr(fields)
    end

    def index_column_names
      []
    end

    def table_columns
      index_column_names.map { |col| { data: col.to_s } }
    end
  end

  def name_with_link
    ApplicationController.helpers.link_to_resource(self)
  end
end
