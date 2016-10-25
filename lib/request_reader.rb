require 'pry'

class RequestReader
  
  attr_accessor :diagnostics
  
  def initialize
  @diagnostics = {"Verb" => nil,
                  "Path" => nil,
                  "Protocol" => nil,
                  "Host" => nil,
                  "Port" => nil,
                  "Origin" => nil,
                  "Accept" => nil
  }
  end
  
  def format_request(request_lines)
    format_first_line(request_lines[0])
    format_host(request_lines[1])
    format_accept(request_lines)
  end

  def format_first_line(line)
    split_line = line.split(" ")
    @diagnostics["Verb"] = split_line[0]
    @diagnostics["Path"] = split_line[1]
    @diagnostics["Protocol"] = split_line[2]
  end

  def format_host(line)
    split_line = line.split(":")
    @diagnostics["Host"] = split_line[1][1..-1]
    @diagnostics["Port"] = split_line[2]
    @diagnostics["Origin"] = split_line[1][1..-1]
  end

  def format_accept(request_lines)
    accept_lines = request_lines[6..8] 
    array = accept_lines.map do |element|
      element.split(":") 
    end
    string = []
    array.each_index do |index|
    string << array[index][1]
    end
    @diagnostics["Accept"] = string.join(",").strip
  end

end