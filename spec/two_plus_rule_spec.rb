require 'spec_helper'

RSpec.describe TwoPlusRule do

	let(:travel_card_holder) {
		Item.new('001', 'Travel Card Holder', 9.25)
	}

	let(:kids_t_shirt) {
		Item.new('003', 'Kids T-shirt', 19.95)
	}

	let(:promotional_price) { 8.50 }

	subject { TwoPlusRule.new( travel_card_holder.product_code, promotional_price ) }

	it { is_expected.to respond_to(:promotional_item) }
	it { is_expected.to respond_to(:promotional_price) }
	

	describe '#execute_rule' do
		context 'when 2 or more card holders are detected' do
			let(:basket) {
				[ travel_card_holder, travel_card_holder, kids_t_shirt ]
			}

			before { subject.execute_rule(basket) }

			it 'should update the travel card holders price' do
				travel_card_holder_items = basket.select { |item| item.product_code == travel_card_holder.product_code  }
				
				travel_card_holder_items.each do |item|
					expect(item.price).to eq(8.50)
				end
			end

			it 'should not change any other item price' do
				kids_t_shirt_item = basket.detect { |item| item.product_code == kids_t_shirt.product_code }
				expect(kids_t_shirt_item.price).to eq(19.95)
			end
		end

		context 'when 1 or less card holders are detected' do
			let(:basket) {
				[ travel_card_holder, kids_t_shirt ]
			}

			before { subject.execute_rule(basket) }

			it 'should not update the travel card holders price' do
				travel_card_holder_item = basket.detect { |item| item.product_code == travel_card_holder.product_code  }
				expect(travel_card_holder_item.price).to eq(9.25)
			end
		end
	end
end