require_relative 'model'

module BestbuyApi
  # Defines the attributes for the categories api. Documentation is
  # located at https://bestbuyapis.github.io/api-documentation/#categories-api.
  class Category < Model
    PATH = 'categories'.freeze

    ATTRIBUTES = {
      id: { search: true },
      name: { search: true },
      subcategory_id: { kw: 'subCategories.id' },
      subcategory_name: { kw: 'subCategories.name' }
    }.freeze
  end
end
