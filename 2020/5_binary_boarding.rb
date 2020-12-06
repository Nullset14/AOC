max = Float::MIN
min = Float::MAX
sum = 0
bit_map = { "B" => 1, "F" => 0, "R" => 1, "L" => 0 }

input.each do |seat|
  binary_code = seat.chars.map { |zone| bit_map[zone] }.join
  seat_number = binary_code[0..6].to_i(2) * 8 + binary_code[7..9].to_i(2)
  max = [seat_number, max].max
  min = [seat_number, min].min
  sum += seat_number
end

puts max
puts (min..max).sum - sum
