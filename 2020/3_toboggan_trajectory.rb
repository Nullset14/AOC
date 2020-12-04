def traverse(right, down, geology)
  trees = 0
  grid_x = 0
  grid_y = 0

  loop do
    grid_x += down
    grid_y = (grid_y + right).divmod(geology[0].length).last
    trees += 1 if geology[grid_x][grid_y] == "#"

    break if (grid_x + down >= geology.length)
  end

  trees
end

geology = input.split("\n").map(&:chars)

puts traverse(3, 1, geology)
puts [[3, 1], [1, 1], [5, 1], [7, 1], [1, 2]].inject(1) { |product, path| product * traverse(*path, geology) }
