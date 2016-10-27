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
    assert game.number
    assert game.guesses
  end

end