require_relative 'criteria'

module BestbuyApi
  # Chains method calls to build up queries
  class Model
    def self.select(*args)
      Criteria.new(self).select(args.uniq)
    end

    def self.where(args)
      Criteria.new(self).where(args)
    end

    def self.limit(args)
      Criteria.new(self).limit(args)
    end

    def self.page(args)
      Criteria.new(self).page(args)
    end
  end
end
