RSpec.describe BestbuyApi::Request do
  let(:api_key) { 'BestbuyApiKey' }

  it { expect(BestbuyApi::Request.ancestors).to include(HTTParty) }
  it { expect(BestbuyApi::Request.base_uri).to eq('https://api.bestbuy.com/v1') }

  describe '#initialize' do
    before do
      restore_default_config
    end

    it 'raises exception without parameters' do
      expect { BestbuyApi::Request.new }.to raise_error(ArgumentError)
    end

    it 'raises exception without Api Key' do
      expect { BestbuyApi::Request.new('products', {}, {}) }.to raise_error(BestbuyApi::MissingApiKeyError)
    end
  end

  context 'when given an Api Key' do
    before do
      BestbuyApi.config.api_key = api_key
    end

    let(:request) { BestbuyApi::Request.new('products', {}, {}) }

    it { expect(request).to respond_to(:items) }
    it { expect(request).to respond_to(:pagination) }
    it { expect(request).to respond_to(:url) }

    after do
      restore_default_config
    end
  end
end
