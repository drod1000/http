require 'minitest/autorun'
require 'minitest/pride'
require './lib/request_reader'

class RequestReaderTest < Minitest::Test

def test_it_can_create_a_request_reader
  request_reader = RequestReader.new
  assert request_reader
end

end