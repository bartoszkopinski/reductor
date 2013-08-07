class Reductor
  module Reductions
    module Sum

      def emit
        if fields.size > 1
          "emit({#{fields.join(", ")} }, #{translated_sum_field});"
        else
          "emit(#{fields.first.translated}, #{translated_sum_field});"
        end
      end

      def translated_sum_field
        "this.#{@sum_field}"
      end

      def sum field, options = {}
        @sum_field = field
        @as = options[:as]
      end

      def as
        @as
      end

      def reduce
        %Q{
          function(key, values) {
            return Array.sum(values);
          }
        }
      end

      def finalize
        if as
          "function(key, values) { return { #{as}: values }; }"
        else
          "function(key, values) { return values; }"
        end
      end

    end
  end
end
