class Game
  attr_reader   :number
  attr_accessor :guesses,
                :last_guess
  
  def initialize
    @number = rand(0..100)
    @guesses = 0
    @last_guess = nil
  end

  def guess_number(guess)
    if guess != last_guess
      @guesses += 1
      @last_guess = guess
    end
    return "You win! It took #{guesses} guesses." if guess == number
    return "Too low.#{guesses} guesses so far." if guess < number
    "Too high. #{guesses} guesses so far." if guess > number
  end

  def feedback
    return "Last guess was #{last_guess}. #{guess_number(last_guess)}" if last_guess
    "No guesses have been made so far."
  end
end