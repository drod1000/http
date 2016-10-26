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
      
      parsed = Parser.new
      parsed.format_request(request_lines)

      
      if parsed.path == "/hello"
        response = "<pre>" + "Hello, World! (#{counter})" + "</pre>"
      elsif parsed.path == "/datetime"
        response = Time.now.strftime('%e %b %Y %H:%M:%S%p').to_s
      elsif parsed.path == "/shutdown"
        response = "Total Requests: #{counter}"
        @running = false
      else
      ##Move to parser class
        response = "<pre>"
        parsed.diagnostics.each do |key, value|
          response << "#{key} : #{value}\n"
        end
        response << "</pre>"
      end

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
