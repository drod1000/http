require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'

class GameTest < Minitest::Test
  
  def test_it_can_create_a_game
    game = Game.new
    assert game
  end

end