require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'

class GameTest < Minitest::Test
  attr_reader :game

  def setup
    @game = Game.new
  end

  def test_it_can_create_a_game
    assert game
  end

  def test_it_initializes_with_random_number_and_guesses
    assert_instance_of Fixnum, game.number
    assert_instance_of Fixnum, game.guesses
  end

  def test_it_returns_feedback_string_for_low_guess
    solution = game.number 
    low_guess = solution - 1

    assert_equal "Too low. 1 guesses so far.", game.guess_number(low_guess)
  end

  def test_it_returns_feedback_string
    assert game.guess_number(25)
    assert game.guess_number(50)
    assert game.guess_number(75)
  end
end