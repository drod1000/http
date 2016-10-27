require 'minitest/autorun'
require 'minitest/pride'
require './lib/parser'

class ParserTest < Minitest::Test

  attr_reader   :parser,
                :request_lines
  def setup
    @parser = Parser.new
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
  def test_it_can_create_a_parser
    assert parser
  end
  def test_it_can_assign_verb
    parser.format_request(request_lines)
    assert_equal "GET", parser.diagnostics["Verb"]
  end
  def test_it_can_assign_path
    parser.format_request(request_lines)
    assert_equal "/", parser.diagnostics["Path"]
  end
  def test_it_can_assign_protocol
    parser.format_request(request_lines)
    assert_equal "HTTP/1.1", parser.diagnostics["Protocol"]
  end
  def test_it_can_assign_host
    parser.format_request(request_lines)
    assert_equal "127.0.0.1", parser.diagnostics["Host"]
  end
  def test_it_can_assign_port
    parser.format_request(request_lines)
    assert_equal "9292", parser.diagnostics["Port"]
  end
  def test_it_can_assign_origin
    parser.format_request(request_lines)
    assert_equal "127.0.0.1", parser.diagnostics["Origin"]
  end
  def test_it_can_assign_accept
    parser.format_request(request_lines)
    assert_equal "*/*, gzip, deflate, sdch, br, en-US,en;q=0.8,fr-FR;q=0.6,fr;q=0.4", parser.diagnostics["Accept"]
  end
  def test_it_can_return_path
    parser.format_request(request_lines)
    assert_equal "/", parser.path
  end
  def test_it_can_return_diagnostics_hash
    before = {"Verb"=>nil, 
              "Path"=>nil, 
              "Parameter"=>nil,
              "Value"=>nil,
              "Protocol"=>nil,
              "Host"=>nil, 
              "Port"=>nil, 
              "Origin"=>nil, 
              "Accept"=>nil}
    assert_equal before, parser.return_diagnostics
    parser.format_request(request_lines)
    after = {"Verb"=>"GET", 
                "Path"=>"/", 
                "Parameter"=>nil,
                "Value"=>nil,
                "Protocol"=>"HTTP/1.1", 
                "Host"=>"127.0.0.1", 
                "Port"=>"9292", 
                "Origin"=>"127.0.0.1", 
                "Accept"=>"*/*, gzip, deflate, sdch, br, en-US,en;q=0.8,fr-FR;q=0.6,fr;q=0.4"}
    assert_equal after, parser.return_diagnostics
  end
end