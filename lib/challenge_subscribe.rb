# frozen_string_literal: true

require_relative 'challenge_subscribe/shopping_basket'
require_relative 'challenge_subscribe/purchase'

input = File.read(ARGV.first)

current_shopping_basket = ShoppingBasket.new

input.lines.each do |line|
  matched_purchase_data = line.match(/(?<quantity>\A\d+) (?<imported>imported )?(?<item>.+) at (?<unit_price>\d+\.\d{2})/)

  current_shopping_basket.add_purchase(
    quantity: matched_purchase_data['quantity'],
    imported: matched_purchase_data['imported'],
    item: matched_purchase_data['item'],
    unit_price: matched_purchase_data['unit_price']
  )
end

current_shopping_basket.make_receipt
