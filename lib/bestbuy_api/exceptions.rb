module BestbuyApi
  class MissingApiKeyError < ArgumentError; end
  class MissingAttributeError < ArgumentError; end
  class RequestError < StandardError; end
end
