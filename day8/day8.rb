class Grid

  attr_reader :grid

  def initialize(input_string)
    rows = input_string.split("\r\n")
    @grid = rows.map{ |row| row.split("").map(&:to_i) }
  end

  def height_at(x, y)
    @grid[y][x]
  end

  def edge_tree_count
    (height * 2) + ((width - 2) * 2)
  end

  def to_s
    grid.map{ |row| row.join("") }.join("\n")
  end

  def height
    @grid.size
  end

  def width
    @grid[0].size
  end

end

tree_grid = Grid.new(File.open("day8/input.txt").read)
# puts tree_grid

visible_trees = tree_grid.edge_tree_count


puts "\n"
(1..tree_grid.height - 2).each do |y|
  (1..tree_grid.width - 2).each do |x|
    height = tree_grid.height_at(x, y)

    left_scan = (0..x-1).map{ |new_x| tree_grid.height_at(new_x, y) }
    right_scan = (x+1..tree_grid.width-1).map{ |new_x| tree_grid.height_at(new_x, y) }
    up_scan = (0..y-1).map{ |new_y| tree_grid.height_at(x, new_y) }
    down_scan = (y+1..tree_grid.height-1).map{ |new_y| tree_grid.height_at(x, new_y) }

    visible = left_scan.max < height || right_scan.max < height || up_scan.max < height || down_scan.max < height
    if visible
      visible_trees += 1
    end

    # puts "(#{x}, #{y}) - Height: #{height} Visible: #{visible}"
  end
end


puts "Visible trees: #{visible_trees}"