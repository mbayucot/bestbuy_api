require 'httparty'

module BestbuyApi
  # Wrap HTTParty gem to query the api
  class Request
    include HTTParty
    base_uri 'https://api.bestbuy.com/v1'
    PAGE_VARS = %w[totalPages total currentPage].freeze

    def initialize(path, attributes, criteria)
      # Get your API Key at https://developer.bestbuy.com/.
      api_key = BestbuyApi.config.api_key
      raise MissingApiKeyError, 'API Key is not defined' if api_key.nil?

      @path = path
      @attributes = attributes
      @criteria = criteria
      @query = { apiKey: api_key, format: 'json' }
    end

    def items
      response[@path] if response.key?(@path)
    end

    def pagination
      response.select { |k| PAGE_VARS.include?(k) }
    end

    def url
      response.request.last_uri.to_s
    end

    private

    def response
      @response ||= find
    end

    def find
      response = self.class.get("/#{@path}#{slug}", query: params)
      raise RequestError, "#{response.code} Request Error" if response.code != 200

      response
    end

    # Collect attributes that are readable and substitute using kw or key
    def slug
      attributes = @attributes.select { |_k, v| v.key?(:search) && v[:search] }
      opts = @criteria[:conditions].map do |k, v|
        attributes[k].key?(:kw) ? { attributes[k][:kw] => v } : { k => v }
      end
      opts = opts.reduce({}, :merge)

      encode_slug(opts)
    end

    # Collect attributes that are searchable and substitute using kw or key
    def params
      attributes = @attributes.select { |_k, v| v.key?(:read) ? v[:read] : true }
      opts = Array[@criteria[:attributes].map do |k|
        attributes[k].key?(:kw) ? attributes[k][:kw] : k
      end].join(',')

      join_fields(opts)
    end

    def encode_slug(opts)
      search = opts.delete('search') if opts.key?('search')
      slug = URI.encode_www_form(opts)
      slug = format("(search=#{search})%<and>s", and: ("&#{slug}" unless slug.empty?)) if search
      return "(#{slug})" unless slug.empty?
    end

    def join_fields(opts)
      params = @criteria.slice(:limit, :page)
      params[:show] = opts unless opts.empty?
      @query.merge!(params) unless params.empty?
      @query
    end
  end
end
