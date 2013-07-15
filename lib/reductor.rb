module Mongoid
  class Criteria

    def reduct(reduction_type, &block)
      reductor = Reductor.new(self, reduction_type, &block)
      Hash[reductor.reduct.map{|e| [e['_id'], e["value"]] }]
    end

  end
end

require 'reductor/reductions'
require 'reductor/field'
require 'reductor/translated_field'

class Reductor

  attr_accessor :collection, :type, :block, :fields

  def initialize(collection, type, &block)
    self.collection = collection
    self.type = type
    self.block = block
  end

  def by(*fields)
    self.fields = fields.map do |f|
      if f.is_a?(Hash)
        f.map{ |k,v| Reductor::TranslatedField.new(k, v) }
      else
        Reductor::Field.new(f)
      end
    end
  end

  def map
    %Q{
      function() {
        #{emit}
      }
    }
  end

  def reduct
    self.extend reduction_module
    instance_eval &block
    @collection.map_reduce(map, reduce).out(out)
  end

  def out
    { inline: true }
  end

  def reduction_module
    "Reductor::Reductions::#{@type.to_s.classify}".constantize
  end

end

