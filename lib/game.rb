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
    end
    @last_guess = guess
    feedback = ""
    if guess == number
      feedback = "You win! It took #{guesses} guesses."
    elsif guess < number
      feedback = "Too low.#{guesses} guesses so far."
    else
      feedback = "Too high. #{guesses} guesses so far."
    end
  feedback
  end

  def feedback
    feedback = ""
    if last_guess
      feedback = "Last guess was #{last_guess}. #{guess_number(last_guess)}"
    else
      feedback = "No guesses have been made so far."
    end
    feedback
  end
end