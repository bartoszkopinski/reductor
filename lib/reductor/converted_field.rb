class Reductor
  class ConvertedField < Struct.new(:field_name, :translation_type)

    def to_s
      "#{field_name}: (#{translated})"
    end

    def translated
      if translation_type.respond_to?(:call)
        translation_type.call(field_name)
      else
        send(translation_type, field_name)
      end
    end

    private

    def to_hour(field_name)
      "this.#{field_name} ? new Date(this.#{field_name}.getFullYear(), this.#{field_name}.getMonth(), this.#{field_name}.getDate(), this.#{field_name}.getHours()) : this.#{field_name}"
    end

    def to_day(field_name)
      "this.#{field_name} ? new Date(this.#{field_name}.getFullYear(), this.#{field_name}.getMonth(), this.#{field_name}.getDate()) : this.#{field_name}"
    end

    def to_month(field_name)
      "this.#{field_name} ? new Date(this.#{field_name}.getFullYear(), this.#{field_name}.getMonth()) : this.#{field_name}"
    end

    def to_year(field_name)
      "this.#{field_name} ? new Date(this.#{field_name}.getFullYear()) : this.#{field_name}"
    end

    def presence(field_names)
      [field_names].flatten.map{|e| "(this.#{e} ? true : false)" }.join(" && ")
    end

  end
end
