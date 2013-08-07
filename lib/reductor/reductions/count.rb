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
