require 'minitest/autorun'
require 'minitest/pride'
require './lib/http'
require 'faraday'
require 'pry'

class HTTPTest < Minitest::Test

  def self.test_order
    :alpha
  end
  def test_it_initializes_with_server_and_counter
    http = HTTP.new 
    assert_equal TCPServer, http.tcp_server.class 
    assert_equal 0, http.counter
  end

  def test_faraday_works
    response = Faraday.get("http://127.0.0.1:9292/")
    assert_equal 200, response.status
 end

 def test_hello_world
  response = Faraday.get("http://127.0.0.1:9292/hello")
  assert_equal "<html><head></head><body><pre>Hello, World! (3)</pre></body></html>", response.body
  response = Faraday.get("http://127.0.0.1:9292/hello")
  assert_equal "<html><head></head><body><pre>Hello, World! (4)</pre></body></html>", response.body
  response = Faraday.get("http://127.0.0.1:9292/hello")
  assert_equal "<html><head></head><body><pre>Hello, World! (5)</pre></body></html>", response.body
 end

 def test_diagnostics
  response = Faraday.get("http://127.0.0.1:9292/")
  assert response.body
  end
 
 def test_date_time
 response = Faraday.get("http://127.0.0.1:9292/datetime")
 time = Time.now.strftime('%e %b %Y %H:%M:%S%p').to_s
 assert response.body.include?(time)
 end

 def test_it_can_extract_parameters
  response = Faraday.get("http://127.0.0.1:9292/?word=hello")
  assert response.body.include?("Parameter : word")
  assert response.body.include?("Value : hello")
 end

 def test_it_can_confirm_known_word
  response = Faraday.get("http://127.0.0.1:9292/word_search?word=hello")
  expected = "is a known word"
  assert response.body.include?(expected)
  response_2 = Faraday.get("http://127.0.0.1:9292/word_search?word=apple")
  expected_2 = "is a known word."
  assert response.body.include?(expected_2)
 end

 def test_it_can_refute_unknown_word
  response = Faraday.get("http://127.0.0.1:9292/word_search?word=aaaaa")
  expected = "is not a known word"
  assert response.body.include?(expected)
 end

 def test_it_can_start_game_with_post_only
 response_1 = Faraday.get("http://127.0.0.1:9292/start_game")
 response_2 = Faraday.post("http://127.0.0.1:9292/start_game")
 expected = "Good luck"
 refute response_1.body.include?(expected)
 assert response_2.body.include?(expected)
 end
 
 def test_shutdown
 response = Faraday.get("http://127.0.0.1:9292/shutdown")
 assert response.body.include?("Total Requests:")
 end

end