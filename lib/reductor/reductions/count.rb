class Reductor
  module Reductions
    module Count

      def emit
        if fields.size > 1
          "emit({ #{fields.join(", ") } , 1);"
        else
          "emit(#{fields.first} , 1);"
        end
      end

      def reduce
        %Q{
          function(key, values) {
            return Array.sum(values);
          }
        }
      end

    end
  end
end
