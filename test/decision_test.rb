require 'minitest/autorun'
require 'minitest/pride'
require './lib/decision'

class DecisionTest < Minitest::Test
  
  def test_it_can_create_decision
    decision = Decision.new
    assert decision
  end

  def test_it_can
  end
  
end
