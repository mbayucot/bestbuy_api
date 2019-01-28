RSpec.describe BestbuyApi::Store do
  let(:fake_api_key) { '123FakeApiKey' }
  let(:invalid_api_key) { '123Key' }
  let(:path) { 'stores' }
  let(:stores) do
    BestbuyApi::Store.select(:id, :city, :state, :postal_code, :store_type,
                             :name, :address, :address2, :country, :hours, :phone)
                     .where(id: 281, city: 'Bloomington', state: 'CA',
                            postal_code: '55423')
                     .limit(10)
                     .page(1)
  end

  it { expect(BestbuyApi::Store).to be < BestbuyApi::Model }

  describe '#path' do
    context 'when given an invalid path' do
      it { expect(BestbuyApi::Store.path).to be_nil }
    end

    context 'when given a valid path' do
      it { expect(BestbuyApi::Store.path('stores')).to eq(path) }
    end
  end

  describe '#attribute' do
    context 'when given an invalid attribute' do
      it 'raises a an argument error' do
        expect { BestbuyApi::Store.attribute }.to raise_error(ArgumentError)
      end
    end

    context 'when given a valid attribute' do
      it { expect(BestbuyApi::Store.attribute(:city, search: true)).to include(city: { search: true }) }
    end
  end

  describe '#select' do
    context 'when given an invalid attribute' do
      it 'raises a missing attribute error' do
        expect { BestbuyApi::Store.select(:names) }.to raise_error(BestbuyApi::MissingAttributeError)
      end
    end

    context 'when given a valid attribute' do
      it { expect(BestbuyApi::Store.select(:name)).to be_instance_of(BestbuyApi::Criteria) }
    end
  end

  describe '#where' do
    context 'when given an invalid attribute' do
      it 'raises a missing attribute error' do
        expect { BestbuyApi::Store.where(ids: '123') }.to raise_error(BestbuyApi::MissingAttributeError)
      end
    end

    context 'when given a valid attribute' do
      it { expect(BestbuyApi::Store.where(id: '123')).to be_instance_of(BestbuyApi::Criteria) }
    end
  end

  describe '#limit' do
    context 'when given a value' do
      it { expect(BestbuyApi::Store.limit(1)).to be_instance_of(BestbuyApi::Criteria) }
    end
  end

  describe '#page' do
    context 'when given a value' do
      it { expect(BestbuyApi::Store.page(1)).to be_instance_of(BestbuyApi::Criteria) }
    end
  end

  describe '#items' do
    it { expect(BestbuyApi::Store.select(:name)).to respond_to(:items) }

    context 'when given a valid Api Key' do
      before do
        BestbuyApi.config.api_key = fake_api_key
      end

      it 'returns a response' do
        VCR.use_cassette(path, record: :new_episodes) do
          expect(stores.items).to_not be_nil
        end
      end

      it 'returns items with the specified fields' do
        VCR.use_cassette(path, record: :new_episodes) do
          store = BestbuyApi::Store.select(:name, :city)
          expect(store.items.first.keys).to eq(%w[name city])
        end
      end
    end

    context 'when given an invalid Api Key' do
      it 'raises a Request Error' do
        VCR.use_cassette(path, record: :new_episodes) do
          BestbuyApi.config.api_key = invalid_api_key
          store = BestbuyApi::Store.select(:name)
          expect { store.items }.to raise_error(BestbuyApi::RequestError)
        end
      end
    end
  end

  describe '#pagination' do
    it { expect(BestbuyApi::Store.limit(10).page(2)).to respond_to(:pagination) }

    context 'when given a valid Api Key' do
      it 'returns a response' do
        VCR.use_cassette(path, record: :new_episodes) do
          BestbuyApi.config.api_key = fake_api_key
          store = BestbuyApi::Store.select(:name)
          expect(store.pagination).to_not be_nil
        end
      end
    end

    context 'when given an invalid Api Key' do
      it 'raises a Request Error' do
        VCR.use_cassette(path, record: :new_episodes) do
          BestbuyApi.config.api_key = invalid_api_key
          store = BestbuyApi::Store.select(:name)
          expect { store.pagination }.to raise_error(BestbuyApi::RequestError)
        end
      end
    end
  end

  describe '#url' do
    it { expect(stores).to respond_to(:url) }

    context 'when given a valid Api Key' do
      before do
        BestbuyApi.config.api_key = fake_api_key
      end

      it 'returns a response' do
        VCR.use_cassette(path, record: :new_episodes) do
          expect(stores.url).to_not be_nil
        end
      end

      it 'returns the correct url' do
        VCR.use_cassette(path, record: :new_episodes) do
          expect(stores.url).to eq('https://api.bestbuy.com/v1/stores(storeId=281&city=Bloomington&region=CA&fullPostalCode=55423)?apiKey=123FakeApiKey&format=json&limit=10&page=1&show=storeId%2Ccity%2Cregion%2CfullPostalCode%2CstoreType%2Cname%2Caddress%2Caddress2%2Ccountry%2Chours%2Cphone')
        end
      end
    end

    context 'when given an invalid Api Key' do
      it 'raises a Request Error' do
        VCR.use_cassette(path, record: :new_episodes) do
          BestbuyApi.config.api_key = invalid_api_key
          expect { stores.url }.to raise_error(BestbuyApi::RequestError)
        end
      end
    end
  end
end
