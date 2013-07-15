class Reductor
  class SimpleField < Struct.new(:field_name)

    def to_s
      "#{field_name}: #{translated}"
    end

    def translated
      "this.#{field_name}"
    end

  end
end
