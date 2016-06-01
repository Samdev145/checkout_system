class Checkout

	attr_reader :promotional_rules, :basket, :price

	def initialize(promotional_rules)
		@promotional_rules = promotional_rules
		@basket = []
	end

	def scan(item)
		basket << item
	end

	def total
		promotional_rules.each do |rule|
			@price = rule.execute_rule(basket)
		end
		format_result(price)
	end

	private

	def format_result(num)
		sprintf "£%.2f", num
	end

end