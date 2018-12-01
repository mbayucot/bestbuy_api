require_relative 'model'
require_relative 'request'

module BestbuyApi
  # Defines the attributes for the stores api. Documentation is
  # located at https://bestbuyapis.github.io/api-documentation/#stores-api.
  class Store < Model
    PATH = 'stores'.freeze

    ATTRIBUTES = {
      id: { kw: 'storeId', search: true },
      city: { search: true },
      state: { kw: 'region', search: true },
      postal_code: { kw: 'fullPostalCode', search: true },
      store_type: { kw: 'storeType' },
      name: {}, address: {}, address2: {}, country: {},
      hours: {}, phone: {}
    }.freeze
  end
end
