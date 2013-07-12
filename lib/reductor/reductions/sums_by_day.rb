class Reductor
  module Reductions
    module SumsByDay

      def datetime_field
        @options[:field] || 'created_at'
      end

      def value_field
        @options[:value_field] || 'count'
      end

      def map
        %Q{
          function() {
            if(this.#{datetime_field}){
              date = new Date(this.#{datetime_field}.getFullYear(), this.#{datetime_field}.getMonth(), this.#{datetime_field}.getDate());
            } else {
              date = null;
            }
            emit(date , this.#{value_field});
          }
        }
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
