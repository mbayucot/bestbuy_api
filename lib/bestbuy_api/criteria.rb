require_relative 'params'
require_relative 'request'
require 'forwardable'

module BestbuyApi
  class Criteria
    extend Forwardable
    def_delegators :response, :items, :pagination, :url

    def initialize(klass)
      @klass = klass
    end

    def criteria
      @criteria ||= { attributes: [], conditions: {} }
    end

    def select(args)
      assert_keys(args, @klass.attributes[:read])

      criteria[:attributes] = args
      self
    end

    def where(args)
      assert_keys(args, @klass.attributes[:search])

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

    def response
      params = Params.new(criteria, @klass.attributes)
      request.find(params.structure)
    end

    private

    def assert_keys(args, attributes)
      valid_keys = attributes.keys
      args.each do |key, _v|
        unless valid_keys.include?(key)
          raise MissingAttributeError, "Unknown attribute: #{key.inspect}. Valid attributes are: " \
                            "#{valid_keys.map(&:inspect).join(', ')}"
        end
      end
    end

    def request
      api_key = BestbuyApi.config.api_key
      @request ||= Request.new(api_key, @klass.attributes[:path])
    end
  end
end
