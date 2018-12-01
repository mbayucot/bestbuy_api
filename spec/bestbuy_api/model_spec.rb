RSpec.describe BestbuyApi::Model do
  it { expect(BestbuyApi::Model).to respond_to(:select).with_unlimited_arguments }
  it { expect(BestbuyApi::Model).to respond_to(:where).with(1).arguments }
  it { expect(BestbuyApi::Model).to respond_to(:limit).with(1).arguments }
  it { expect(BestbuyApi::Model).to respond_to(:page).with(1).arguments }
end
