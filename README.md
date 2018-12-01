# Best Buy API

[![Build Status](https://travis-ci.org/mbayucot/bestbuy_api.svg?branch=master)](https://travis-ci.org/mbayucot/bestbuy_api)

A Ruby wrapper for the [Best Buy developer API](https://developer.bestbuy.com/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bestbuy_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bestbuy_api

## Getting Started
 Sign-up for a developer API Key at https://developer.bestbuy.com/

## API Documentation

Documentation for the Best Buy API is located at [bestbuyapis.github.io](https://bestbuyapis.github.io/api-documentation/).

## Usage

``` ruby
require 'bestbuy_api'

BestbuyApi.config.api_key = 'YourBestbuyApiKey'

product = BestbuyApi::Product.select(:sku, :name, :sale_price, :url, :image)
                             .where(keyword: 'iPhone')
                             .limit(10).page(1)
product.items.each do |item|
  item['sku']
end
```

## Find products

``` ruby
product = BestbuyApi::Product.select(:sku, :name, :sale_price, :url, :image)
product.items
```

## Find categories

``` ruby
category = BestbuyApi::Category.select(:id, :name, :subcategory_id, :subcategory_name)
category.items
```

## Find stores

``` ruby
store = BestbuyApi::Store.select(:id, :city, :state, :postal_code)
store.items
```

## Selecting Specific Fields

``` ruby
BestbuyApi::Product.select(category_id: 'abcat500')
```

## Conditions

``` ruby
BestbuyApi::Product.where(category_id: 'abcat500')
```

## Limit and Offset

``` ruby
BestbuyApi::Product.limit(20).page(2)
```

## Pagination

``` ruby
product = BestbuyApi::Product.where(category_id: 'abcat500')
product.pagination or product.url
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
