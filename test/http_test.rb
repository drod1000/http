require 'minitest/autorun'
require 'minitest/pride'
require './lib/http'

class HTTPTest < Minitest::Test
  
  def test_it_initializes_with_server_and_counter
    http = HTTP.new 
    assert_equal TCPServer, http.tcp_server.class 
    assert_equal 0, http.counter
  end

end