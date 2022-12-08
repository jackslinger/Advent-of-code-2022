lines = File.open("day7/input.txt").read.split("\n")

class Directory
  attr_reader :name, :parent, :contents

  def initialize(name, parent)
    @name = name
    @parent = parent
    @contents = []
  end

  def add_directory(directory)
    # TODO: Add some uniquness checking here
    @contents << directory
  end

  def add_file(file)
    # TODO: Add some uniquness checking here
    @contents << file
  end

  def size
    @contents.map(&:size).sum
  end

  def directories
    [self] + @contents.select{ |item| item.is_a?(Directory) }.map(&:directories).flatten
  end

  def to_s
    "#{name}: #{@contents.map(&:name).join(" ")}"
  end

end

class File
  attr_reader :name, :size

  def initialize(string)
    @size, @name = string.split(" ")
    @size = @size.to_i
  end

  def to_s
    "#{@size} #{@name}"
  end

end

root = Directory.new(:root, nil)
current_directory = root

index = 0

while index < lines.size
  line = lines[index]

  if line =~ /\$ cd (.+)/
    opcode = $1
    if opcode == "/"
      current_directory = root
    elsif opcode == ".."
      current_directory = current_directory.parent
    else
      new_dir = Directory.new(opcode, current_directory)
      current_directory.add_directory(new_dir)
      current_directory = new_dir
    end
    index += 1
  elsif line =~ /\$ ls/
    # Handle reading files and dirs and building the tree
    index += 1
    line = lines[index]
    while line && line[0] != "$"
      if line && !(line =~ /\Adir/)
        file = File.new(line)
        current_directory.add_file(file)
      end

      index += 1
      line = lines[index]
    end
  else
    raise "Unexpected command: #{line}"
  end
end

# Part 1

total_of_all_dirs_less_than_100000 = root.directories.select{ |dir| dir.size <= 100000 }.map(&:size).sum
puts "Total of all dirs less than 100000: #{total_of_all_dirs_less_than_100000}"

# Part 2

total_space = 70000000
space_needed = 30000000

puts "Currently used space: #{root.size}"
space_remaining = total_space - root.size
puts "Currently free space: #{space_remaining}"
size_to_delete = space_needed - space_remaining
puts "Extra space required: #{size_to_delete}"

smallest_suitable_directory = root.directories.select{ |dir| dir.size >= size_to_delete }.min{ |a, b| a.size <=> b.size }
puts "The smallest directory to delete and make enough room is #{smallest_suitable_directory.name} with a size of #{smallest_suitable_directory.size}"