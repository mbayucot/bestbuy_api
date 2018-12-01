require 'bestbuy_api/exceptions'
require 'bestbuy_api/product'
require 'bestbuy_api/store'
require 'bestbuy_api/category'

# Handles BestBuy api queries. Documentation is located at
# https://bestbuyapis.github.io/api-documentation.
module BestbuyApi
  class << self
    attr_accessor :api_key

    def config
      self
    end
  end
end
