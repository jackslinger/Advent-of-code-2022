class Round
  attr_reader :opponent_code, :your_code
  
  def initialize(input_string)
    opponent_code, your_code = input_string.split(" ")
    
    @opponent_code = opponent_code
    @your_code = your_code
  end

  def opponent_choice
    {
      "A" => :rock,
      "B" => :paper,
      "C" => :scissors
    }[opponent_code]
  end
  
  def your_choice
    # X means loose
    # Y means draw
    # Z means win
  end

  def score
    # TODO
    0
  end
end


rounds = File.open("day2/input.txt").read.split("\n").map{ |line| Round.new(line) }

# rounds.each_with_index do |round, index|
#   puts "Round #{index + 1}: opponent #{round.opponent_choice} you #{round.your_choice}, score: #{round.score}"
# end

puts "\nTotal score: #{rounds.map(&:score).sum}" 