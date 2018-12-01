RSpec.describe BestbuyApi::Criteria do
  let(:criteria) { BestbuyApi::Criteria.new({}) }

  it { expect(criteria).to respond_to(:select).with(1).arguments }
  it { expect(criteria).to respond_to(:where).with(1).arguments }
  it { expect(criteria).to respond_to(:limit).with(1).arguments }
  it { expect(criteria).to respond_to(:page).with(1).arguments }
  it { expect(criteria).to respond_to(:items) }
  it { expect(criteria).to respond_to(:pagination) }
  it { expect(criteria).to respond_to(:url) }
end
