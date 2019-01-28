RSpec.describe BestbuyApi do
  let(:api_key) { 'BestbuyApiKey' }

  context 'when no api key is specified' do
    before do
      BestbuyApi.config.api_key = nil
    end

    it 'returns nil' do
      expect(BestbuyApi.config.api_key).to be_nil
    end
  end

  context 'when given an api key' do
    before do
      BestbuyApi.config.api_key = api_key
    end

    it 'returns the specified value' do
      expect(BestbuyApi.config.api_key).to eq(api_key)
    end

    after do
      BestbuyApi.config.api_key = nil
    end
  end
end
