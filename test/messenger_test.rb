require 'minitest/autorun'
require 'minitest/pride'
require './lib/messenger'

class MessengerTest < Minitest::Test
  
  def test_it_can_create_messenger
    messenger = Messenger.new
    assert messenger
  end
  
end