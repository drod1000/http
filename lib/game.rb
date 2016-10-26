class Game

  attr_reader :number

  def initialize
    @number = rand(0..100)
    @guesses = 0
  end

  def guess_number(guess)
  end
end