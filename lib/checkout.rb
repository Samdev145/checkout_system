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
		price
	end

end