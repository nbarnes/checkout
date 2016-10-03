
require_relative './pricing_rules.rb'
require_relative './shopping_item.rb'

class Checkout

  attr_reader :pricing_rules, :inventory, :cart

  def initialize(pricing_rules)
    @pricing_rules = pricing_rules
    @inventory = Inventory.new
    @cart = {}
  end

  def add_shopping_item(shopping_item)
    @inventory.add_shopping_item shopping_item
  end

  def scan(product_code)
    raise ArgumentError, 'Unrecognized product code' unless @inventory.has_item product_code
    if @cart.key? product_code
      @cart[product_code] = (@cart[product_code] + 1)
    else
      @cart[product_code] = 1
    end
  end

  def total
    total = 0
    @cart.each_pair do |product_code, count|
      item = @inventory.shopping_item product_code
      unit_price = item.price
      subtotal = 0

      bulk_rule = @pricing_rules.bulk_pricing_rule product_code
      if bulk_rule && count >= bulk_rule[:threshold]
        unit_price = bulk_rule[:bulk_price]
      end

      (count = (count.to_f / 2).ceil) if @pricing_rules.buy_1_get_1_rule product_code

      total = total + (count * unit_price)
    end
    return total
  end

end
