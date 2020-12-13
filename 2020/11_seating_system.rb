class WaitingArea
  DIRECTIONS = [1, -1, 0, 1, -1].combination(2).to_a.uniq

  attr_reader :initial_layout, :visible_occupied, :neighbor_depth

  def initialize(initial_layout, visible_occupied, neighbor_depth = Float::INFINITY)
    @initial_layout = initial_layout
    @visible_occupied = visible_occupied
    @neighbor_depth = neighbor_depth
  end

  def layout
    @layout ||= initial_layout
  end

  def model
    loop { break unless next_round }
  end

  def next_round
    changed = false
    new_layout = []

    layout.each_with_index do |seats, row|
      new_layout[row] ||= []

      seats.each_with_index do |seat, col|
        occupied_seats = DIRECTIONS.reduce(0) { |sum, direction| sum + occupancy(row, col, *direction) }

        if seat == "L" && occupied_seats.zero?
          changed = true
          new_layout[row][col] = "#"
        elsif seat == "#" && occupied_seats >= visible_occupied
          changed = true
          new_layout[row][col] = "L"
        else
          new_layout[row][col] = seat
        end
      end
    end

    @layout = new_layout
    changed
  end

  def occupancy(row, col, row_direction, col_direction)
    1.upto(neighbor_depth) do
      return 0 if (row + row_direction).negative? || (col + col_direction).negative?

      seat = layout[row + row_direction] && layout[row + row_direction][col + col_direction]
      case seat
      when "."
        row += row_direction
        col += col_direction
      when "#"
        return 1
      else
        return 0
      end
    end

    0
  end
end

initial_layout = input.split("\n").map(&:chars)

waiting_area = WaitingArea.new(initial_layout, 4, 1)
waiting_area.model
puts waiting_area.layout.flatten.count { |seat| seat == "#" }

waiting_area = WaitingArea.new(initial_layout, 5)
waiting_area.model
puts waiting_area.layout.flatten.count { |seat| seat == "#" }
