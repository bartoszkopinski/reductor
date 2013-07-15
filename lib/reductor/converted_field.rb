class Reductor
  class ConvertedField < Struct.new(:field_name, :translation_type)

    def to_s
      "#{field_name}: (#{translated})"
    end

    def translated
      send(translation_type, field_name)
    end

    private

    def to_day(field_name)
      "this.#{field_name} ? new Date(this.#{field_name}.getFullYear(), this.#{field_name}.getMonth(), this.#{field_name}.getDate()) : this.#{field_name}"
    end

  end
end
