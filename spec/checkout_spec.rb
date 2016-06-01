require 'spec_helper'

RSpec.describe Checkout do
	

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

	let(:promotional_rules) {
		[
			TwoPlusRule.new('001', 8.50),
			TotalDiscountRule.new(discount_percentage, qualify_amount)
		]
	}
	
	subject { Checkout.new(promotional_rules) }

	it { is_expected.to respond_to(:promotional_rules) }
	it { is_expected.to respond_to(:basket) }

	describe '#scan' do

		it 'should increase the basket array by 1' do
			expect{
				subject.scan(travel_card_holder)
			}.to change(subject.basket, :count).by(1)
		end

	end

	describe '#total' do

		context 'with a basket of products 001, 002, 003' do

			before do
				subject.scan(travel_card_holder)
				subject.scan(personalised_cufflinks)
				subject.scan(kids_t_shirt)
			end

			it 'should return the correct total price' do
				price = subject.total
				expect(price).to eq("£66.78")
			end
		end

		context 'with a basket of products 001, 002, 003' do

			before do
				subject.scan(travel_card_holder)
				subject.scan(kids_t_shirt)
				subject.scan(travel_card_holder)
			end

			it 'should return the correct total price' do
				price = subject.total
				expect(price).to eq("£36.95")
			end
		end

		context 'with a basket of products 001, 002, 003' do

			before do
				subject.scan(travel_card_holder)
				subject.scan(personalised_cufflinks)
				subject.scan(travel_card_holder)
				subject.scan(kids_t_shirt)
			end

			it 'should return the correct total price' do
				price = subject.total
				expect(price).to eq("£73.76")
			end
		end
	end
end