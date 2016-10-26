require './lib/parser'
require 'socket'
require './lib/messenger'
require 'pry'

class HTTP
  attr_reader :tcp_server,
              :counter
  def initialize
    @tcp_server = TCPServer.new(9292)
    @counter = 0
    @running = true
  end

  def get_request
    while @running
      client = tcp_server.accept

      puts "Ready for a request"
      request_lines = []

      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
      
      parser = Parser.new
      parser.format_request(request_lines)
      parsed = parser.return_diagnostics
      ##Move entire if statement to Router
      if parsed["Path"] == "/hello"
        response = "<pre>" + "Hello, World! (#{counter})" + "</pre>"
      elsif parsed["Path"] == "/datetime"
        response = Time.now.strftime('%e %b %Y %H:%M:%S%p').to_s
      elsif parsed["Path"] == "/shutdown"
        response = "Total Requests: #{counter}"
        @running = false
      else
      ##Move to Router
        response = "<pre>"
        parser.diagnostics.each do |key, value|
          response << "#{key} : #{value}\n"
        end
        response << "</pre>"
      end
      ##Add if response includes Total Requests then running is false

      messenger = Messenger.new
      output = messenger.output(response)
      client.puts messenger.headers(output)
      client.puts messenger.output(response)

      client.close
      @counter += 1
    end
  end
end

http = HTTP.new
http.get_request
