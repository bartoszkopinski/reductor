class Reductor
  module Reductions
    module CountsByDay

      def datetime_field
        @options[:field] || 'created_at'
      end

      def extra_fields
        [@options[:group_by]].flatten
      end

      def map
        %Q{
          function() {
            if(this.#{datetime_field}){
              date = new Date(this.#{datetime_field}.getFullYear(), this.#{datetime_field}.getMonth(), this.#{datetime_field}.getDate());
            } else {
              date = null;
            }
            #{emit}
          }
        }
      end

      def emit
        if extra_fields
          fields = extra_fields.map{|e| "#{e}: this.#{e}" }.join(", ")
          "emit({ date: date, #{fields} }, 1)"
        else
          "emit(date , 1);"
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
