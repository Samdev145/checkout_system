require 'spec_helper'

RSpec.describe Item do
	
	subject { Item.new('001', 'Travel Card Holder', 9.25) }

	it { is_expected.to respond_to(:product_code) }
	it { is_expected.to respond_to(:name) }
	it { is_expected.to respond_to(:price) }

end