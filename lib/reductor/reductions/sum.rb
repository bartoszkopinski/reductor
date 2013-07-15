class Reductor
  module Reductions
    module Sum

      def emit
        if fields.size > 1
          "emit({ #{fields.join(", ")} } , #{translated_sum_field});"
        else
          "emit( #{fields.first.translated} , #{translated_sum_field});"
        end
      end

      def translated_sum_field
        "this.#{@sum_field}"
      end

      def sum field, options = {}
        @sum_field = field
        @sum_field_name = options[:as] || @sum_field
      end

      def reduce
        %Q{
          function(key, values) {
            return Array.sum(values);
          }
        }
      end

      def finalize
        %Q{
          function(key, values) {
            return { #{@sum_field_name}: values };
          }
        }
      end

    end
  end
end
