# frozen_string_literal: true

# Calculates price and taxes of a single item according to its quantity.
class Purchase
  attr_reader :quantity, :item, :imported, :final_item_taxes, :final_item_price

  def initialize(quantity, imported, item, unit_price)
    @quantity = quantity.to_i
    @imported = !imported.nil?
    @item = item
    @unit_price = unit_price.to_f
    @unit_basic_sales_tax = calculate_unit_basic_sales_tax(@item, @unit_price)
    @unit_import_duty = calculate_unit_import_duty(@imported, @unit_price)
    @unit_total_taxes = calculate_unit_total_taxes(@unit_basic_sales_tax, @unit_import_duty)
    @final_item_taxes = calculate_final_item_taxes(@unit_total_taxes, @quantity)
    @final_item_price = calculate_final_item_price(@unit_price, @unit_total_taxes, @quantity)
  end

  def calculate_unit_basic_sales_tax(item, unit_price)
    basic_sales_tax_exemption = ['book', 'chocolate bar', 'box of chocolates', 'boxes of chocolates',
                                 'packet of headache pills']
    if basic_sales_tax_exemption.include?(item)
      0
    else
      unit_price * 0.1
    end
  end

  def calculate_unit_import_duty(imported, unit_price)
    if imported
      unit_price * 0.05
    else
      0
    end
  end

  def calculate_unit_total_taxes(unit_basic_sales_tax, unit_import_duty)
    ((unit_basic_sales_tax + unit_import_duty) * 20).ceil / 20.0
  end

  def calculate_final_item_taxes(total_taxes, quantity)
    (total_taxes * quantity)
  end

  def calculate_final_item_price(unit_price, unit_total_taxes, quantity)
    ((unit_price + unit_total_taxes) * quantity).round(2)
  end
end
