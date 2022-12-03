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

    if your_code == "X"
      if opponent_choice == :rock
        :scissors
      elsif opponent_choice == :paper
        :rock
      elsif opponent_choice == :scissors
        :paper
      end
    elsif your_code == "Y"
      if opponent_choice == :rock
        :rock
      elsif opponent_choice == :paper
        :paper
      elsif opponent_choice == :scissors
        :scissors
      end
    elsif your_code == "Z"
      if opponent_choice == :rock
        :paper
      elsif opponent_choice == :paper
        :scissors
      elsif opponent_choice == :scissors
        :rock
      end
    end
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


rounds = File.open("day2/example.txt").read.split("\n").map{ |line| Round.new(line) }

puts "\nTotal score: #{rounds.map(&:score).sum}" 