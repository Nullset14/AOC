require "set"

instructions = input.split("\n")

def run_code(instructions)
  accumulator = 0
  current_line = 0
  visited = Set.new

  loop do
    return [accumulator, current_line] if (visited.include? current_line) || (current_line >= instructions.length)

    operation, argument = instructions[current_line].split(" ")
    visited << current_line

    case operation
    when "jmp"
      current_line += argument.to_i
    when "acc"
      accumulator += argument.to_i
      current_line += 1
    else
      current_line += 1
      next # nop
    end
  end
end

accumulator, current_line = run_code(instructions)
puts accumulator

0.upto(current_line).each do |index|
  case instructions[index][0..2]
  when "jmp"
    instructions[index][0..2] = "nop"
  when "nop"
    instructions[index][0..2] = "jmp"
  else
    next
  end

  accumulator, current_line = run_code(instructions)
  if current_line >= instructions.length
    puts accumulator
    break
  else
    instructions[index][0..2] = instructions[index][0..2] == "jmp" ? "nop" : "jmp"
  end
end
