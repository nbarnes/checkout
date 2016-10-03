
require_relative './minitest_helper.rb'
require_relative '../checkout.rb'
require 'pry'

class TestCheckout < MiniTest::Test

  def setup
    pricing_rules = PricingRules.new
    pricing_rules.add_buy_1_get_1_rule('FR1')
    pricing_rules.add_bulk_purchase_rule(product_code: 'AP1', bulk_price: 450, threshold: 3)
    @checkout = Checkout.new(pricing_rules)
    @checkout.add_shopping_item ShoppingItem.new(product_code: 'FR1', name: 'Fruit tea', price: 311)
    @checkout.add_shopping_item ShoppingItem.new(product_code: 'AP1', name: 'Apple', price: 500)
    @checkout.add_shopping_item ShoppingItem.new(product_code: 'CF1', name: 'Coffee', price: 1123)
  end

  def test_checkout1
    shopping_cart = %w(FR1 AP1 FR1 CF1)
    expected_price = 1934
    shopping_cart.each do |product_code|
      @checkout.scan(product_code)
    end
    assert_equal expected_price, @checkout.total
  end

  def test_checkout2
    shopping_cart = %w(FR1 FR1)
    expected_price = 311
    shopping_cart.each do |product_code|
      @checkout.scan(product_code)
    end
    assert_equal expected_price, @checkout.total
  end

  def test_checkout3
    shopping_cart = %w(AP1 AP1 FR1 AP1)
    expected_price = 1661
    shopping_cart.each do |product_code|
      @checkout.scan(product_code)
    end
    assert_equal expected_price, @checkout.total
  end

end
