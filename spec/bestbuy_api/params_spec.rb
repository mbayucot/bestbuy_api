RSpec.describe BestbuyApi::Params do
  describe '#initialize' do
    it 'raises exception without parameters' do
      expect { BestbuyApi::Params.new }.to raise_error(ArgumentError)
    end
  end

  describe '#structure' do
    let(:params) do
      criteria = {
        attributes: %i[id name],
        conditions: { name: 'Electronics' },
        limit: 10,
        page: 1
      }
      attributes = {
        read: { id: { search: true }, name: { search: true } },
        search: { id: { search: true }, name: { search: true } }
      }
      BestbuyApi::Params.new(criteria, attributes)
    end

    it { expect(params).to respond_to(:structure) }

    context 'when given a valid criteria and attributes' do
      it { expect(params.structure).to eq(query: { limit: 10, page: 1, show: 'id,name' }, slug: '(name=Electronics)') }
    end
  end
end
