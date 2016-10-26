require 'minitest/autorun'
require 'minitest/pride'
require './lib/router'

class RouterTest < Minitest::Test
  
  def test_it_can_create_router
    router = Router.new({"Path"=>"/"}, 0)
    assert router
  end

  def test_it_can_return_hello_string
    expected = "<pre>Hello, World! (1)</pre>"
    assert_equal expected, Router.new({"Path"=>"/hello"}, 1).response
  end

  def test_it_can_return_time_string
    router = Router.new({"Path"=>"/datetime"}, 1)
    assert_equal Time.now.strftime('%e %b %Y %H:%M:%S%p').to_s, router.response
  end

  def test_it_can_return_shutdown_string
    expected = "Total Requests: 1"
    assert_equal expected, Router.new({"Path"=>"/shutdown"}, 1).response
  end

  def test_it_can_confirm_match_in_dictionary
    router = Router.new({"Path"=>"/"}, 0)
    assert router.match_in_dictionary("apple")
    assert router.match_in_dictionary("strawberry")
  end

  def test_it_can_return_string_confirming_match_in_dictionary
    router = Router.new({"Path"=>"/"}, 0)
    expected = "apple is a known word."
    assert_equal expected, router.word_search("apple")
  end
  
  def test_it_can_return_string_denying_match_in_dictionary
    router = Router.new({"Path"=>"/"}, 0)
    expected = "aaaaa is not a known word."
    assert_equal expected, router.word_search("aaaaa")
  end

end
