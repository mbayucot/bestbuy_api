module BestbuyApi
  class Response
    PAGE_VARS = %w[totalPages total currentPage].freeze

    def initialize(result, path)
      @result = result
      @path = path
    end

    def items
      @result[@path] if @result.key?(@path)
    end

    def pagination
      @result.select { |key| PAGE_VARS.include?(key) }
    end

    def url
      @result.request.last_uri.to_s
    end
  end
end
