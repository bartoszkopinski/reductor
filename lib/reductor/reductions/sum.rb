class Reductor
  module Reductions
    module Sum

      def emit
        if fields.size > 1
          "emit({ #{fields.join(", ")} } , #{translated_value});"
        else
          "emit( #{fields.first} , #{translated_value});"
        end
      end

      def translated_value
        "this.#{@value}"
      end

      def value arg
        @value =  arg
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
