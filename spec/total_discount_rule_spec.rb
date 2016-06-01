require 'spec_helper'

RSpec.describe TotalDiscountRule do

	let(:travel_card_holder) {
		Item.new('001', 'Travel Card Holder', 9.25)
	}

	let(:personalised_cufflinks) {
		Item.new('002', 'Personalised cufflinks', 45.00)
	}

	let(:kids_t_shirt) {
		Item.new('003', 'Kids T-shirt', 19.95)
	}
	
	let(:discount_percentage) { 10 }
	let(:qualify_amount) { 60 }

	subject { TotalDiscountRule.new(discount_percentage, qualify_amount) }

	it { is_expected.to respond_to(:discount_percentage) }
	it { is_expected.to respond_to(:qualify_amount) }

	describe '#execute_rule' do

		context 'when the total is over the qualiying amount' do

			let(:basket) { 
				[ travel_card_holder, personalised_cufflinks, kids_t_shirt ] 
			}

			it 'should deduct the discount_percentage from the total' do
				price = subject.execute_rule(basket)
				expect(price).to eq(66.78)
			end
		end

		context 'when the total is under the qualiying amount' do
			let(:basket) { [ travel_card_holder, kids_t_shirt ] }
			
			it 'should not deduct anything from the price' do
				price = subject.execute_rule(basket)
				expect(price).to eq(29.20)
			end
		end
	end
end