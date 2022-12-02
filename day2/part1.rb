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
    {
      "X" => :rock,
      "Y" => :paper,
      "Z" => :scissors
    }[your_code]
  end

  def score
    if your_choice == :rock
      if opponent_choice == :rock
        1 + 3
      elsif opponent_choice == :paper
        1 + 0
      elsif opponent_choice == :scissors
        1 + 6
      end
    elsif your_choice == :paper
      if opponent_choice == :rock
        2 + 6
      elsif opponent_choice == :paper
        2 + 3
      elsif opponent_choice == :scissors
        2 + 0
      end
    elsif your_choice == :scissors
      if opponent_choice == :rock
        3 + 0
      elsif opponent_choice == :paper
        3 + 6
      elsif opponent_choice == :scissors
        3 + 3
      end
    end
  end
end


rounds = File.open("day2/input.txt").read.split("\n").map{ |line| Round.new(line) }

# rounds.each_with_index do |round, index|
#   puts "Round #{index + 1}: opponent #{round.opponent_choice} you #{round.your_choice}, score: #{round.score}"
# end

puts "\nTotal score: #{rounds.map(&:score).sum}"


# Not sure what is wrong here
def score_for_round(round_string)
  {
    "A X" => (1 + 3),
    "A Y" => (1 + 6),
    "A Z" => (1 + 0),
    "B X" => (2 + 0),
    "B Y" => (2 + 3),
    "B Z" => (2 + 6),
    "C X" => (3 + 6),
    "C Y" => (3 + 0),
    "C Z" => (3 + 3),
  }[round_string]
end

total = File.readlines("day2/input.txt").map(&:chomp).map{ |round| score_for_round(round) }.sum
puts "\nTotal score (new way): #{total}"