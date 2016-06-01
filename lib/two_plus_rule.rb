class TwoPlusRule

	attr_reader :promotional_item, :promotional_price, :basket

	def initialize(promotional_item, promotional_price)
		@promotional_item = promotional_item
		@promotional_price = promotional_price
	end

	def execute_rule(basket)
		@basket = basket
		if matched_items.count > 1
			matched_items.map { |item| item.price = promotional_price } 
		end

		total_price
	end

	private

	def total_price
		basket.inject(0) { |price, item| price + item.price }
	end

	def matched_items
		basket.select { |item| item.product_code == promotional_item }
	end

end
