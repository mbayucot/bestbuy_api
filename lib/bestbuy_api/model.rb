require_relative 'criteria'

module BestbuyApi
  class Model
    def self.attributes
      @attributes ||= { path: nil, read: {}, search: {} }
    end

    def self.path(path = nil)
      attributes[:path] = path
    end

    def self.attribute(id, columns = { search: false, read: true })
      row = { id => columns }
      attributes[:read].merge!(row) unless columns[:read] == false
      attributes[:search].merge!(row) unless columns[:search] == false
    end

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
