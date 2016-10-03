require 'pry'

class ShoppingItem
  attr_accessor :product_code, :name, :price
  def initialize(product_code:, name:, price:)
    @product_code = product_code
    @name = name
    @price = price
  end
end

class Inventory

    def initialize
      @shopping_items = {}
    end

    def has_item(product_code)
      return @shopping_items[product_code]
    end

    def add_shopping_item(shopping_item)
      @shopping_items[shopping_item.product_code] = shopping_item
    end

    def shopping_item(product_code)
      return shopping_items[product_code]
    end

    private
      attr_accessor :shopping_items

end
