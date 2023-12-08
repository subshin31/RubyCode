class GroceryCheckout
  attr_reader :pricing_table, :items, :total_price, :total_savings

  def initialize(pricing_table)
    @pricing_table = pricing_table
    @items = {}
    @total_price = 0
    @total_savings = 0
  end

  def input_items
    puts "Enter items you want to purchase separated by a comma:"
    user_input = gets.chomp.downcase.split(',')

    user_input.each do |item|
      item_name = item.strip.capitalize
      @items[item_name] ||= 0
      @items[item_name] += 1
    end
  end

  def calculate_totals
    puts "\nItem   Quantity    Price"
    puts "****************************"

    @items.each do |item, quantity|
      price_data = @pricing_table[item]

      if price_data[:sale_price] && quantity >= price_data[:sale_quantity]
        sale_count = quantity / price_data[:sale_quantity]
        unit_count = quantity % price_data[:sale_quantity]
        price = (sale_count * price_data[:sale_price]) + (unit_count * price_data[:unit_price])
        savings = (quantity * price_data[:unit_price]) - price
      else
        price = quantity * price_data[:unit_price]
        savings = 0
      end

      @total_price += price
      @total_savings += savings

      puts "#{item.ljust(8)} #{quantity.to_s.ljust(13)} $#{'%.2f' % price}"
    end
  end

  def display_totals
    puts "\nTotal price: $#{'%.2f' % @total_price}"
    puts "You saved $#{'%.2f' % @total_savings} today."
  end
end

pricing_table = {
  'Milk'  => { unit_price: 3.97, sale_price: 5.00, sale_quantity: 2 },
  'Bread' => { unit_price: 2.17, sale_price: 6.00, sale_quantity: 3 },
  'Banana' => { unit_price: 0.99 },
  'Apple' => { unit_price: 0.89 }
}

checkout = GroceryCheckout.new(pricing_table)
checkout.input_items
checkout.calculate_totals
checkout.display_totals
