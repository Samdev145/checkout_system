class TotalDiscountRule

	attr_reader :discount_percentage, :qualify_amount, :basket

	def initialize(discount_percentage, qualify_amount)
		@discount_percentage = discount_percentage
		@qualify_amount = qualify_amount
	end
	

	def execute_rule(basket)
		@basket = basket
		
		if total_price > qualify_amount
			return minus_percentage(discount_percentage)
		end

		total_price
	end

	private

	def total_price
		basket.inject(0) { |price, item| price + item.price }
	end

	def minus_percentage(discount_percentage)
		discount = (total_price / 100) * discount_percentage
		(total_price - discount).round(2)
	end

end