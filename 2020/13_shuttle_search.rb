# Part 1

earliest_time, bus_ids = input.split("\n")
earliest_time = earliest_time.to_i
bus_ids = bus_ids.split(",").reject { |id| id == "x" }.map(&:to_i)
next_departure = bus_ids.map.with_index { |id, index| bus_ids[index] - earliest_time % id }
time, index = next_departure.each_with_index.min

puts time * bus_ids[index]


# Part 2

def inverse_modulo(multiplier, divisor)
  multiplier = multiplier % divisor
  number = multiplier
  return 1 if number == 1

  loop do
    number += multiplier
    break if number % divisor == 1
  end

  number / multiplier
end

def chinese_remainder(divisors, remainders)
  product = divisors.inject(:*)
  products = divisors.map { |divisor| product / divisor }
  inverses = products.map.with_index { |pair_product, index| inverse_modulo(pair_product, divisors[index]) }
  [products, inverses, remainders].transpose.sum { |a| a.inject(:*) } % product
end

earliest_time, bus_ids = input.split("\n")
earliest_time = earliest_time.to_i
bus_ids = bus_ids.split(",").map.with_index { |id, index| [id.to_i, index] unless id == "x" }.compact.to_h

puts chinese_remainder(bus_ids.keys, bus_ids.values.map { |x| -x }) % bus_ids.keys.inject(:*)
