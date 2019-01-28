RSpec.describe BestbuyApi::Request do
  let(:api_key) { '123FakeApiKey' }

  it { expect(BestbuyApi::Request.ancestors).to include(HTTParty) }
  it { expect(BestbuyApi::Request.base_uri).to eq('https://api.bestbuy.com/v1') }

  describe '#initialize' do
    it 'raises exception without parameters' do
      expect { BestbuyApi::Request.new }.to raise_error(ArgumentError)
    end

    it 'raises exception without Api Key' do
      expect { BestbuyApi::Request.new('', '') }.to raise_error(BestbuyApi::MissingApiKeyError)
    end
  end

  context 'when given an Api Key' do
    it { expect(BestbuyApi::Request.new(api_key, 'products')).to respond_to(:find) }
  end
end
