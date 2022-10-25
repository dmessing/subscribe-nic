# frozen_string_literal: true

# Contains and shows bought items.
class ShoppingBasket
  def initialize
    @purchases = []
  end

  def add_purchase(quantity:,imported:, item:, unit_price:)
    @purchases << Purchase.new(quantity, imported, item, unit_price)
  end

  def add_trailing_zeros_to(value)
    format('%.2f', value)
  end

  def make_receipt
    @total_sale_taxes = 0
    @total_sale_price = 0

    @purchases.each do |purchase|
      imported = purchase.imported ? 'imported ' : ''

      puts "#{purchase.quantity} #{imported}#{purchase.item}: #{add_trailing_zeros_to(purchase.final_item_price)}"
      @total_sale_taxes += purchase.final_item_taxes
      @total_sale_price += purchase.final_item_price
    end
    puts "Sales Taxes: #{add_trailing_zeros_to(@total_sale_taxes)}"
    puts "Total: #{@total_sale_price}"
  end
end
