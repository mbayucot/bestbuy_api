require_relative 'model'

module BestbuyApi
  # Defines the attributes for the stores api. Documentation is
  # located at https://bestbuyapis.github.io/api-documentation/#stores-api.
  class Store < Model
    path 'stores'

    attribute :id, field: 'storeId', search: true
    attribute :city, search: true
    attribute :state, field: 'region', search: true
    attribute :postal_code, field: 'fullPostalCode', search: true
    attribute :store_type, field: 'storeType'
    attribute :name
    attribute :address
    attribute :address2
    attribute :country
    attribute :hours
    attribute :phone
  end
end
