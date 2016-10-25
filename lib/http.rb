require './lib/request_reader'
require 'socket'
require './lib/messages'

class HTTP
  attr_reader :tcp_server,
              :counter
  def initialize
    @tcp_server = TCPServer.new(9292)
    @counter = 0
  end

  def get_request
    loop do
      client = tcp_server.accept

      puts "Ready for a request"
      request_lines = []

      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
      
      RequestReader.new.format_request(request_lines)



      response = "<pre>" + "Hello, World! (#{counter})" + "</pre>"
      output = Messages.new.output(response)
     
      client.puts Messages.new.headers(output)
      client.puts Messages.new.output(response)

      client.close
      @counter += 1
    end
  end
end

if __FILE__ == $0
  http = HTTP.new
  http.get_request
end