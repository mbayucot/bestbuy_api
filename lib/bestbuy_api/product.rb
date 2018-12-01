require_relative 'model'

module BestbuyApi
  # Defines the attributes for the products api. Documentation is
  # located at https://bestbuyapis.github.io/api-documentation/#products-api.
  class Product < Model
    PATH = 'products'.freeze

    ATTRIBUTES = {
      keyword: { kw: 'search', search: true, read: false },
      sku: { search: true },
      category_id: { kw: 'categoryPath.id', search: true },
      category_name: { kw: 'categoryPath.name', search: true },
      condition: { search: true },
      customer_rating: { kw: 'customerReviewAverage', search: true },
      manufacturer: { search: true },
      regular_price: { kw: 'regularPrice' },
      sale_price: { kw: 'salePrice' },
      shipping_cost: { kw: 'shippingCost' },
      reviews_count: { kw: 'customerReviewCount' },
      discount: { kw: 'percentSavings' },
      free_shipping: { kw: 'freeShipping' },
      url: {}, name: {}, description: {}, image: {}
    }.freeze
  end
end
