require 'forwardable'

module BestbuyApi
  # Collect the parameters and validates the attributes
  class Criteria
    extend Forwardable
    def_delegators :request, :items, :pagination, :url

    def initialize(klass)
      @klass = klass
    end

    def criteria
      @criteria ||= { attributes: [], conditions: {} }
    end

    def select(args)
      # Check on attributes that are readable
      attributes = @klass::ATTRIBUTES.select { |_k, v| v.key?(:read) ? v[:read] : true }
      args.each { |k, _v| assert_keys(attributes.keys, k) }

      criteria[:attributes] = args
      self
    end

    def where(args)
      # Check on attributes that are searchable
      attributes = @klass::ATTRIBUTES.select { |_k, v| v.key?(:search) && v[:search] }
      args.each { |k, _v| assert_keys(attributes.keys, k) }

      criteria[:conditions].merge!(args)
      self
    end

    def limit(limit)
      criteria[:limit] = limit.to_i
      self
    end

    def page(page)
      criteria[:page] = page.to_i
      self
    end

    private

    def request
      @request ||= BestbuyApi::Request.new(@klass::PATH, @klass::ATTRIBUTES, criteria)
    end

    def assert_keys(valid_keys, key)
      return true if valid_keys.include?(key)

      raise MissingAttributeError, "Unknown attribute: #{key.inspect}. Valid attributes are: " \
                            "#{valid_keys.map(&:inspect).join(', ')}"
    end
  end
end
