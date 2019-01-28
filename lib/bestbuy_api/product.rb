require_relative 'model'

module BestbuyApi
  # Defines the attributes for the products api. Documentation is
  # located at https://bestbuyapis.github.io/api-documentation/#products-api.
  class Product < Model
    path 'products'

    attribute :keyword, field: 'search', search: true, read: false
    attribute :sku, search: true
    attribute :category_id, field: 'categoryPath.id', search: true
    attribute :category_name, field: 'categoryPath.name', search: true
    attribute :condition, search: true
    attribute :customer_rating, field: 'customerReviewAverage', search: true
    attribute :manufacturer, search: true
    attribute :regular_price, field: 'regularPrice'
    attribute :sale_price, field: 'salePrice'
    attribute :shipping_cost, field: 'shippingCost'
    attribute :reviews_count, field: 'customerReviewCount'
    attribute :discount, field: 'percentSavings'
    attribute :free_shipping, field: 'freeShipping'
    attribute :url
    attribute :name
    attribute :description
    attribute :image
  end
end
