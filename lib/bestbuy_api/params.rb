module BestbuyApi
  class Params
    def initialize(criteria, attributes)
      @criteria = criteria
      @attributes = attributes
    end

    def structure
      { slug: build_filters, query: build_response_options }
    end

    private

    def build_filters
      collection = collect_search
      collection.empty? ? '' : query_string(collection)
    end

    def build_response_options
      query = @criteria.slice(:limit, :page)
      query[:show] = collect_read
      query
    end

    def collect_read
      Array[@criteria[:attributes].map do |key|
        elements = @attributes[:read]
        if elements.key?(key)
          attribute = elements[key]
          attribute.key?(:field) ? attribute[:field] : key
        end
      end].join(',')
    end

    def collect_search
      @criteria[:conditions].map do |key, value|
        elements = @attributes[:search]
        if elements.key?(key)
          attribute = elements[key]
          attribute.key?(:field) ? { attribute[:field] => value } : { key => value }
        end
      end.reduce({}, :merge)
    end

    def query_string(props)
      search = props.delete('search')
      uri = URI.encode_www_form(props)
      search_query = "(search=#{search})" if search
      uri = format("#{search_query}%<and>s", and: "&#{uri}") if search_query && uri
      "(#{uri})"
    end
  end
end
