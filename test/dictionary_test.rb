require 'minitest/autorun'
require 'minitest/pride'
require './lib/dictionary'

class DictionaryTest < Minitest::Test
  def test_it_can_find_dictionary
    dictionary = Dictionary.new
    assert dictionary
  end
  def test_it_can_find_match_in_dictionary
    dictionary = Dictionary.new
    assert dictionary.find_match("apple")
    assert dictionary.find_match("strawberry")
  end
  def test_it_wont_confirm_if_word_is_not_in_dictionary
    dictionary = Dictionary.new
    refute dictionary.find_match("aaaaa")
    refute dictionary.find_match("ggggg")
  end
end