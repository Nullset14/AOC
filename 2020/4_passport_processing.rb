valid = 0
strict_valid = 0

required_fields = %w[byr ecl eyr hcl hgt iyr pid]
ecls = %w[amb blu brn gry grn hzl oth]

input.split("\n\n").each do |passport|
  credentials = passport.split(/\s/).map { |x| x.split(":") }.to_h
  valid += 1 if required_fields.all? { |field| credentials.key?(field) }

  next unless ("1920".."2002").cover? credentials["byr"]
  next unless ("2010".."2020").cover? credentials["iyr"]
  next unless ("2020".."2030").cover? credentials["eyr"]
  
  next unless credentials["hgt"]
  case credentials["hgt"][-2..-1]
  when "cm"
    next unless ("150".."193").cover? credentials["hgt"][0..-3]
  when "in"
    next unless ("59".."76").cover? credentials["hgt"][0..-3]
  else
    next
  end

  next unless credentials["hcl"]
  next unless credentials["hcl"] =~ /^#[0-9a-f]{6}$/
  next unless ecls.include? credentials["ecl"]
  next unless credentials["pid"]
  next unless credentials["pid"] =~ /^[0-9]{9}$/

  strict_valid += 1
end

puts valid
puts strict_valid
