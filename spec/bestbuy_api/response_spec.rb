RSpec.describe BestbuyApi::Response do
  let(:response) { BestbuyApi::Response.new({}, 'products') }

  describe '#initialize' do
    it 'raises exception without parameters' do
      expect { BestbuyApi::Response.new }.to raise_error(ArgumentError)
    end
  end

  it { expect(response).to respond_to(:items) }
  it { expect(response).to respond_to(:pagination) }
  it { expect(response).to respond_to(:url) }
end
