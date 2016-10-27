require 'minitest/autorun'
require 'minitest/pride'
require './lib/router'

class RouterTest < Minitest::Test
  attr_reader :router
  def setup
  @router = Router.new
  end
  def test_it_can_create_router
    assert router
  end

  def test_it_can_return_hello_string
    expected = "<pre>Hello, World! (1)</pre>"
    assert_equal expected, router.response({"Path"=>"/hello"}, 1)
  end

  def test_it_can_return_time_string
    assert_equal Time.now.strftime('%e %b %Y %H:%M:%S%p').to_s, router.response({"Path"=>"/datetime"}, 1)
  end

  def test_it_can_return_shutdown_string
    expected = "Total Requests: 1"
    assert_equal expected, router.response({"Path"=>"/shutdown"}, 1)
  end

  def test_it_can_confirm_match_in_dictionary
    assert router.match_in_dictionary("apple")
    assert router.match_in_dictionary("strawberry")
  end

  def test_it_can_return_string_confirming_match_in_dictionary
    expected = "apple is a known word."
    assert_equal expected, router.word_search("apple")
  end
  
  def test_it_can_return_string_denying_match_in_dictionary
    expected = "aaaaa is not a known word."
    assert_equal expected, router.word_search("aaaaa")
  end

end
