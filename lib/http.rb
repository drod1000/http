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
=begin
#DIAGNOSTICS
#Need Whitespace after every line
#Pull out once path has been created
      response = ""
      request_reader.diagnostics.each do |key, value|
         response << "#{key} : #{value}\n"
      end
=end

      response = "<pre>" + "Hello, World! (#{counter})" + "</pre>"
      
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
