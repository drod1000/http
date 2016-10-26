require './lib/request_reader'
require 'socket'
require './lib/messenger'
require 'pry'

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
      
      request_reader = RequestReader.new
      request_reader.format_request(request_lines)
      
      if request_reader.path == "/"
        response = "<pre>"
        request_reader.diagnostics.each do |key, value|
          response << "#{key} : #{value}\n"
        end
        response << "</pre>"
      elsif request_reader.path == "/hello"
        response = "<pre>" + "Hello, World! (#{counter})" + "</pre>"
      elsif request_reader.path == "/datetime"
        response = Time.now.strftime('%e %b %Y %H:%M:%S%p').to_s
      elsif request_reader.path == "/shutdown"
        response = "Total Requests: #{counter}"
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
