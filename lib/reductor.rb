module Mongoid
  class Criteria

    def reduction(reduction_type, out: :inline, options: {})
      reductor = Reductor.new(self, reduction_type, options)
      Hash[reductor.reduce.out(inline: true).map{|e| [e['_id'], e["value"]] }]
    end

  end
end

require 'reductor/reductions'

class Reductor

  def initialize(collection, type, options)
    @collection = collection
    @type = type
    @options = options
  end

  def reduce
    self.extend reduction_module
    @collection.map_reduce(map, reduce)
  end

  def reduction_module
    "Reductor::Reductions::#{@type.to_s.classify}".constantize
  end

end

