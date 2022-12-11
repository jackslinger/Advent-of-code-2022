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

  def visible_trees
    count = edge_tree_count

    (1..height - 2).each do |y|
      (1..width - 2).each do |x|
        tree_height = height_at(x, y)

        visible = left_scan(x, y).max < tree_height || right_scan(x, y).max < tree_height || up_scan(x, y).max < tree_height || down_scan(x, y).max < tree_height
        if visible
          count += 1
        end
      end
    end

    count
  end

  def scenic_score(x, y)
    # puts "Up: "
    up_score = viewing_distance(x, y, up_scan(x, y))
    # puts up_score

    # puts "Left: "
    left_score = viewing_distance(x, y, left_scan(x, y))
    # puts left_score

    # puts "Right: "
    right_score = viewing_distance(x, y, right_scan(x, y))
    # puts right_score

    # puts "Down: "
    down_score = viewing_distance(x, y, down_scan(x, y))
    # puts down_score

    left_score * right_score * down_score * up_score
  end

  private

  def left_scan(x, y)
    (0..x-1).map{ |new_x| height_at(new_x, y) }.reverse
  end

  def right_scan(x, y)
    (x+1..width-1).map{ |new_x| height_at(new_x, y) }
  end

  def up_scan(x, y)
    (0..y-1).map{ |new_y| height_at(x, new_y) }.reverse
  end

  def down_scan(x, y)
    (y+1..height-1).map{ |new_y| height_at(x, new_y) }
  end

  def viewing_distance(x, y, scan)
    height = height_at(x, y)
    if scan.max < height
      scan.size
    else
      scan.find_index { |other_height| other_height >= height } + 1
    end
  end

end

tree_grid = Grid.new(File.open("day8/input.txt").read)
puts "Visible trees: #{tree_grid.visible_trees}"

# Part 2
puts "\nPart 2\n\n"

# puts "Scenic score (2, 1): #{tree_grid.scenic_score(2, 1)}"
# puts "Scenic score (2, 3): #{tree_grid.scenic_score(2, 3)}"

puts "\n"

scores = []
high_score = 0
target_x = 0
target_y = 0
(1..tree_grid.height - 2).each do |y|
  (1..tree_grid.width - 2).each do |x|
    score = tree_grid.scenic_score(x, y)
    scores << score
    if score > high_score
      target_x = x
      target_y = y
      high_score = score
    end
  end
end

puts "Highest scenic score: #{scores.max}"
puts "(#{target_x},#{target_y}) #{high_score}"