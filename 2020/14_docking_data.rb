# Part 1
mem = {}
mask = ""
input.split("\n").each do |instruction|
  if instruction[0..3] == "mask"
    mask = instruction[7..]
    next
  end

  address, value = instruction.scan(/\d+/).map(&:to_i)
  bits = value.to_s(2).rjust(36, "0").chars
  masked_value = bits.zip(mask.chars).map do |value_bit, mask_bit|
    case mask_bit
    when "X"
      value_bit
    else
      mask_bit
    end
  end.join.to_i(2)

  mem[address] = masked_value
end

puts mem.values.sum

# Part 2
mem = {}
mask = ""
input.split("\n").each do |instruction|
  if instruction[0..3] == "mask"
    mask = instruction[7..]
    next
  end

  address, value = instruction.scan(/\d+/).map(&:to_i)
  bits = address.to_s(2).rjust(36, "0").chars
  masked_address = bits.zip(mask.chars).map do |value_bit, mask_bit|
    case mask_bit
    when "1"
      "1"
    when "X"
      "X"
    else
      value_bit
    end
  end

  floating_count = masked_address.count { |bit| bit == "X" }

  0.upto(2.pow(floating_count) - 1).each do |permutation|
    enumerator = permutation.to_s(2).rjust(floating_count, "0").chars.each
    memory = masked_address.map { |bit| bit == "X" ? enumerator.next : bit }.join.to_i(2)
    mem[memory] = value
  end
end

puts mem.values.sum
