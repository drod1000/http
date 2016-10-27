class Game
  attr_reader   :number
  attr_accessor :guesses
  def initialize
    @number = rand(0..100)
    @guesses = 0
  end
  def guess_number(guess)
    @guesses += 1
    feedback = ""
    if guess == number
      feedback = "You win! It took #{guesses}."
    elsif guess < number
      feedback = "Too low. #{guesses} so far."
    else
      feedback = "Too high. #{guesses} so far."
    end
  feedback
  end
end
