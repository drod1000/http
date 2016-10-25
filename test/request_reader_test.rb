require 'minitest/autorun'
require 'minitest/pride'
require './lib/request_reader'

class RequestReaderTest < Minitest::Test

  attr_reader   :request_reader,
                :request_lines
  def setup
    @request_reader = RequestReader.new
    @request_lines = ["GET / HTTP/1.1", 
                      "Host: 127.0.0.1:9292", 
                      "Connection: keep-alive", 
                      "Cache-Control: no-cache", 
                      "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.71 Safari/537.36", 
                      "Postman-Token: 0abdeb93-7006-613f-71b6-7523ba6c693b", 
                      "Accept: */*", 
                      "Accept-Encoding: gzip, deflate, sdch, br", 
                      "Accept-Language: en-US,en;q=0.8,fr-FR;q=0.6,fr;q=0.4"]
  end

  def test_it_can_create_a_request_reader
    assert request_reader
  end

  def test_it_can_assign_verb
    request_reader.format_request(request_lines)
    assert_equal "GET", request_reader.diagnostics["Verb"]
  end

  def test_it_can_assign_path
    request_reader.format_request(request_lines)
    assert_equal "/", request_reader.diagnostics["Path"]
  end

  def test_it_can_assign_protocol
    request_reader.format_request(request_lines)
    assert_equal "HTTP/1.1", request_reader.diagnostics["Protocol"]
  end

  def test_it_can_assign_host
    request_reader.format_request(request_lines)
    assert_equal "127.0.0.1", request_reader.diagnostics["Host"]
  end

  def test_it_can_assign_port
    request_reader.format_request(request_lines)
    assert_equal "9292", request_reader.diagnostics["Port"]
  end

  def test_it_can_assign_origin
    request_reader.format_request(request_lines)
    assert_equal "127.0.0.1", request_reader.diagnostics["Origin"]
  end

  def test_it_can_assign_accept
    request_reader.format_request(request_lines)
    assert_equal "*/*, gzip, deflate, sdch, br, en-US,en;q=0.8,fr-FR;q=0.6,fr;q=0.4", request_reader.diagnostics["Accept"]
  end

end