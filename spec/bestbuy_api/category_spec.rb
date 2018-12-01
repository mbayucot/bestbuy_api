RSpec.describe BestbuyApi::Category do
  let(:fake_api_key) { '123FakeApiKey' }
  let(:invalid_api_key) { '123Key' }
  let(:path) { 'categories' }
  let(:attributes) do
    {
      id: { search: true },
      name: { search: true },
      subcategory_id: { kw: 'subCategories.id' },
      subcategory_name: { kw: 'subCategories.name' }
    }
  end
  let(:categories) do
    BestbuyApi::Category.select(:id, :name, :subcategory_id, :subcategory_name)
                        .where(id: 'abcat500', name: 'Electronics')
                        .limit(10)
                        .page(1)
  end

  it { expect(BestbuyApi::Category).to be < BestbuyApi::Model }

  it 'should have a path constant' do
    expect(BestbuyApi::Category).to be_const_defined(:PATH)
  end

  it 'should have an attributes constant' do
    expect(BestbuyApi::Category).to be_const_defined(:ATTRIBUTES)
  end

  it 'sets the path constant' do
    expect(BestbuyApi::Category::PATH).to eq(path)
  end

  it 'sets the attribute constant' do
    expect(BestbuyApi::Category::ATTRIBUTES).to eq(attributes)
  end

  describe '#select' do
    context 'when given an invalid attribute' do
      it 'raises a missing attribute error' do
        expect { BestbuyApi::Category.select(:names) }.to raise_error(BestbuyApi::MissingAttributeError)
      end
    end

    context 'when given a valid attribute' do
      it { expect(BestbuyApi::Category.select(:name)).to be_instance_of(BestbuyApi::Criteria) }
    end
  end

  describe '#where' do
    context 'when given an invalid attribute' do
      it 'raises a missing attribute error' do
        expect { BestbuyApi::Category.where(names: '123') }.to raise_error(BestbuyApi::MissingAttributeError)
      end
    end

    context 'when given a valid attribute' do
      it { expect(BestbuyApi::Category.where(name: '123')).to be_instance_of(BestbuyApi::Criteria) }
    end
  end

  describe '#limit' do
    context 'when given a value' do
      it { expect(BestbuyApi::Category.limit(1)).to be_instance_of(BestbuyApi::Criteria) }
    end
  end

  describe '#page' do
    context 'when given a value' do
      it { expect(BestbuyApi::Category.page(1)).to be_instance_of(BestbuyApi::Criteria) }
    end
  end

  describe '#items' do
    it { expect(BestbuyApi::Category.select(:name)).to respond_to(:items) }

    context 'when given a valid Api Key' do
      before do
        BestbuyApi.config.api_key = fake_api_key
      end

      it 'returns a response' do
        VCR.use_cassette(path, record: :new_episodes) do
          expect(categories.items).to_not be_nil
        end
      end

      it 'returns items with the specified fields' do
        VCR.use_cassette(path, record: :new_episodes) do
          category = BestbuyApi::Category.select(:id, :name)
          expect(category.items.first.keys).to eq(%w[id name])
        end
      end
    end

    context 'when given an invalid Api Key' do
      it 'raises a Request Error' do
        VCR.use_cassette(path, record: :new_episodes) do
          BestbuyApi.config.api_key = invalid_api_key
          category = BestbuyApi::Category.select(:name)
          expect { category.items }.to raise_error(BestbuyApi::RequestError)
        end
      end
    end
  end

  describe '#pagination' do
    let(:category) { BestbuyApi::Category.limit(10).page(2) }

    it { expect(category).to respond_to(:pagination) }

    context 'when given a valid Api Key' do
      it 'returns a response' do
        VCR.use_cassette(path, record: :new_episodes) do
          BestbuyApi.config.api_key = fake_api_key
          expect(category.pagination).to_not be_nil
        end
      end
    end

    context 'when given an invalid Api Key' do
      it 'raises a Request Error' do
        VCR.use_cassette(path, record: :new_episodes) do
          BestbuyApi.config.api_key = invalid_api_key
          expect { category.pagination }.to raise_error(BestbuyApi::RequestError)
        end
      end
    end
  end

  describe '#url' do
    it { expect(categories).to respond_to(:url) }

    context 'when given a valid Api Key' do
      before do
        BestbuyApi.config.api_key = fake_api_key
      end

      it 'returns a response' do
        VCR.use_cassette(path, record: :new_episodes) do
          expect(categories.url).to_not be_nil
        end
      end

      it 'returns the correct url' do
        VCR.use_cassette(path, record: :new_episodes) do
          expect(categories.url).to eq('https://api.bestbuy.com/v1/categories(id=abcat500&name=Electronics)?apiKey=123FakeApiKey&format=json&limit=10&page=1&show=id%2Cname%2CsubCategories.id%2CsubCategories.name')
        end
      end
    end

    context 'when given an invalid Api Key' do
      it 'raises a Request Error' do
        VCR.use_cassette(path, record: :new_episodes) do
          BestbuyApi.config.api_key = invalid_api_key
          expect { categories.url }.to raise_error(BestbuyApi::RequestError)
        end
      end
    end
  end
end
