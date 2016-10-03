
class PricingRules
  require 'set'

  def initialize
    @bulk_purchase_rules = {}
    @buy_1_get_1_rules = Set.new
  end

  def add_bulk_purchase_rule(product_code:, bulk_price:, threshold:)
    @bulk_purchase_rules[product_code] = {bulk_price: bulk_price, threshold: threshold}
  end

  def add_buy_1_get_1_rule(product_code)
    @buy_1_get_1_rules << product_code
  end

  def bulk_pricing_rule(product_code)
    return @bulk_purchase_rules[product_code]
  end

  def buy_1_get_1_rule(product_code)
    return @buy_1_get_1_rules.include? product_code
  end

  private

    attr_accessor :bulk_purchase_rules, :buy_1_get_1_rules

end
