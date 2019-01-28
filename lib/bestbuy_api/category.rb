require_relative 'model'

module BestbuyApi
  # Defines the attributes for the categories api. Documentation is
  # located at https://bestbuyapis.github.io/api-documentation/#categories-api.
  class Category < Model
    path 'categories'

    attribute :id, search: true
    attribute :name, search: true
    attribute :subcategory_id, field: 'subCategories.id'
    attribute :subcategory_name, field: 'subCategories.name'
  end
end
