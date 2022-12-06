example = File.open("day6/examples.txt").read.split("\n")[0]
input = File.open("day6/input.txt").read.split("\n")[0]

def start_of_packet(input, packet_size=4)
  input.size.times.each do |i|
    window = input[i..i+(packet_size - 1)].chars
    if window.size == window.uniq.size
      puts "Moved #{i} times"
      puts window.join("")
      return i + packet_size
    end
  end
end


puts start_of_packet(input)
puts start_of_packet(input, 14)

