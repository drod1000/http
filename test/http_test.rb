require 'minitest/autorun'
require 'minitest/pride'
require './lib/http'
require 'faraday'
require 'pry'

class HTTPTest < Minitest::Test

  def test_it_initializes_with_server_and_counter
    http = HTTP.new 
    assert_equal TCPServer, http.tcp_server.class 
    assert_equal 0, http.counter
  end

  def test_faraday_works
    response = Faraday.get("http://127.0.0.1:9292/")
    assert_equal 200, response.status
    assert_equal "Hello World", response.body
 end
 
end