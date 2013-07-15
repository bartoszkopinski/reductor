class Reductor
  class Field < Struct.new(:field_name)

    def to_s
      "#{field_name}: this.#{field_name}"
    end

  end
end
