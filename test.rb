
pricing_table = {
  'Milk'  => { unit_price: 3.97, sale_price: 5.00, sale_quantity: 2 },
  'Bread' => { unit_price: 2.17, sale_price: 6.00, sale_quantity: 3 },
  'Banana' => { unit_price: 0.99 },
  'Apple' => { unit_price: 0.89 }
}
# initialization of variable for list of item
items = {}

puts "Enter items you wanted to purchase seperated by comma :"
user_input = gets.chomp.downcase.split(',')

user_input.each do |item|
  item_name = item.strip.capitalize
  items[item_name] ||= 0
  items[item_name] += 1
end

total_price = 0
total_savings = 0

puts "\nItem   Quantity    Price"
puts "****************************"

items.each do |item, quantity|
  price_data = pricing_table[item]

  if price_data[:sale_price] && quantity >= price_data[:sale_quantity]
    sale_count = quantity / price_data[:sale_quantity]
    unit_count = quantity % price_data[:sale_quantity]
    price = (sale_count * price_data[:sale_price]) + (unit_count * price_data[:unit_price])
    savings = (quantity * price_data[:unit_price]) - price
  else
    price = quantity * price_data[:unit_price]
    savings = 0
  end

  total_price += price
  total_savings += savings

  puts "#{item.ljust(8)} #{quantity.to_s.ljust(13)} $#{'%.2f' % price}"
end

puts "\nTotal price : $#{'%.2f' % total_price}"
puts "You saved $#{'%.2f' % total_savings} today."

