anyone_yes = 0
everyone_yes = 0

input.split("\n\n").each do |group_response|
  person_responses = group_response.split("\n").map(&:chars)
  anyone_yes += person_responses.flatten.uniq.count
  everyone_yes += person_responses.inject(:&).count
end

puts anyone_yes
puts everyone_yes
