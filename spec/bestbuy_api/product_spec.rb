RSpec.describe BestbuyApi::Product do
  let(:fake_api_key) { '123FakeApiKey' }
  let(:invalid_api_key) { '123Key' }
  let(:path) { 'products' }
  let(:attributes) do
    {
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
    }
  end
  let(:products) do
    BestbuyApi::Product.select(:sku, :category_id, :category_name, :condition,
                               :customer_rating, :manufacturer, :regular_price,
                               :sale_price, :shipping_cost, :reviews_count, :discount,
                               :free_shipping, :url, :name, :description, :image)
                       .where(keyword: 'iPhone', sku: '123', category_id: 'abcat500',
                              category_name: 'Electronics', condition: 'new', customer_rating: 5,
                              manufacturer: 'Apple')
                       .limit(10).page(1)
  end

  it { expect(BestbuyApi::Product).to be < BestbuyApi::Model }

  it 'should have a path constant' do
    expect(BestbuyApi::Product).to be_const_defined(:PATH)
  end

  it 'should have an attributes constant' do
    expect(BestbuyApi::Product).to be_const_defined(:ATTRIBUTES)
  end

  it 'sets the path constant' do
    expect(BestbuyApi::Product::PATH).to eq(path)
  end

  it 'sets the attribute constant' do
    expect(BestbuyApi::Product::ATTRIBUTES).to eq(attributes)
  end

  describe '#select' do
    context 'when given an invalid attribute' do
      it 'raises a missing attribute error' do
        expect { BestbuyApi::Product.select(:skus) }.to raise_error(BestbuyApi::MissingAttributeError)
      end
    end

    context 'when given a valid attribute' do
      it { expect(BestbuyApi::Product.select(:sku)).to be_instance_of(BestbuyApi::Criteria) }
    end
  end

  describe '#where' do
    context 'when given an invalid attribute' do
      it 'raises a missing attribute error' do
        expect { BestbuyApi::Product.where(skus: '123') }.to raise_error(BestbuyApi::MissingAttributeError)
      end
    end

    context 'when given a valid attribute' do
      it { expect(BestbuyApi::Product.where(sku: '123')).to be_instance_of(BestbuyApi::Criteria) }
    end
  end

  describe '#limit' do
    context 'when given a value' do
      it { expect(BestbuyApi::Product.limit(1)).to be_instance_of(BestbuyApi::Criteria) }
    end
  end

  describe '#page' do
    context 'when given a value' do
      it { expect(BestbuyApi::Product.page(1)).to be_instance_of(BestbuyApi::Criteria) }
    end
  end

  describe '#items' do
    it { expect(BestbuyApi::Product.select(:sku)).to respond_to(:items) }

    context 'when given a valid Api Key' do
      before do
        BestbuyApi.config.api_key = fake_api_key
      end

      it 'returns a response' do
        VCR.use_cassette(path, record: :new_episodes) do
          expect(products.items).to_not be_nil
        end
      end

      it 'returns items with the specified fields' do
        VCR.use_cassette(path, record: :new_episodes) do
          product = BestbuyApi::Product.select(:sku, :name)
          expect(product.items.first.keys).to eq(%w[sku name])
        end
      end
    end

    context 'when given an invalid Api Key' do
      it 'raises a Request Error' do
        VCR.use_cassette(path, record: :new_episodes) do
          BestbuyApi.config.api_key = invalid_api_key
          product = BestbuyApi::Product.select(:sku)
          expect { product.items }.to raise_error(BestbuyApi::RequestError)
        end
      end
    end
  end

  describe '#pagination' do
    it { expect(BestbuyApi::Product.limit(10).page(2)).to respond_to(:pagination) }

    context 'when given a valid Api Key' do
      it 'returns a response' do
        VCR.use_cassette(path, record: :new_episodes) do
          BestbuyApi.config.api_key = fake_api_key
          product = BestbuyApi::Product.select(:sku)
          expect(product.pagination).to_not be_nil
        end
      end
    end

    context 'when given an invalid Api Key' do
      it 'raises a Request Error' do
        VCR.use_cassette(path, record: :new_episodes) do
          BestbuyApi.config.api_key = invalid_api_key
          product = BestbuyApi::Product.select(:sku)
          expect { product.pagination }.to raise_error(BestbuyApi::RequestError)
        end
      end
    end
  end

  describe '#url' do
    it { expect(products).to respond_to(:url) }

    context 'when given a valid Api Key' do
      before do
        BestbuyApi.config.api_key = fake_api_key
      end

      it 'returns a response' do
        VCR.use_cassette(path, record: :new_episodes) do
          expect(products.url).to_not be_nil
        end
      end

      it 'returns the correct url' do
        VCR.use_cassette(path, record: :new_episodes) do
          expect(products.url).to eq('https://api.bestbuy.com/v1/products((search=iPhone)&sku=123&categoryPath.id=abcat500&categoryPath.name=Electronics&condition=new&customerReviewAverage=5&manufacturer=Apple)?apiKey=123FakeApiKey&format=json&limit=10&page=1&show=sku%2CcategoryPath.id%2CcategoryPath.name%2Ccondition%2CcustomerReviewAverage%2Cmanufacturer%2CregularPrice%2CsalePrice%2CshippingCost%2CcustomerReviewCount%2CpercentSavings%2CfreeShipping%2Curl%2Cname%2Cdescription%2Cimage')
        end
      end
    end

    context 'when given an invalid Api Key' do
      it 'raises a Request Error' do
        VCR.use_cassette(path, record: :new_episodes) do
          BestbuyApi.config.api_key = invalid_api_key
          expect { products.url }.to raise_error(BestbuyApi::RequestError)
        end
      end
    end
  end
end
