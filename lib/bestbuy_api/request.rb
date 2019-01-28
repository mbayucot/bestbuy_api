require 'httparty'
require_relative 'response'

module BestbuyApi
  class Request
    include HTTParty
    base_uri 'https://api.bestbuy.com/v1'

    def initialize(api_key, path)
      raise MissingApiKeyError, 'API Key is not defined' if api_key.empty?

      @path = path
      @options = { apiKey: api_key, format: 'json' }
    end

    def find(params)
      result = self.class.get("/#{@path}#{params[:slug]}", query: @options.merge(params[:query]))
      code = result.code
      raise RequestError, "#{code} Request Error: #{result.request.last_uri}" if code != 200

      Response.new(result, @path)
    end
  end
end
