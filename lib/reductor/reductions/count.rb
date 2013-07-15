class Reductor
  module Reductions
    module Count

      def emit
        if fields.size > 1
          "emit({#{fields.join(", ")}}, 1);"
        else
          "emit(#{fields.first.translated}, 1);"
        end
      end

      def count options
        @as = options[:as]
      end

      def value_field_name
        @as || 'count';
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
            return { #{value_field_name}: values };
          }
        }
      end

    end
  end
end
