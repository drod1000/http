require 'minitest/autorun'
require 'minitest/pride'
require './lib/decision'

class DecisionTest < Minitest::Test
  
  def test_it_can_create_decision
    decision = Decision.new("something", 0)
    assert decision
  end

  def test_it_can_return_hello_string
    expected = "<pre>Hello, World! (1)</pre>"
    assert_equal expected, Decision.new("/hello", 1).response
  end

  def test_it_can_return_time_string
    decision = Decision.new("/datetime", 1)
    assert_equal Time.now.strftime('%e %b %Y %H:%M:%S%p').to_s, decision.response
  end

  def test_it_can_return_shutdown_string
    expected = "Total Requests: 1"
    assert_equal expected, Decision.new("/shutdown", 1).response
  end

end
