require 'pry'

class Parser
  attr_accessor :diagnostics 
  def initialize
    @diagnostics = {"Verb" => nil,
                    "Path" => nil,
                    "Parameter" => nil,
                    "Value" => nil,
                    "Protocol" => nil,
                    "Host" => nil,
                    "Port" => nil,
                    "Origin" => nil,
                    "Accept" => nil
    }
  end

  def format_request(request_lines)
    format_first_line(request_lines[0])
    if post_parameter?
      get_post_paramater(request_lines)
    end
    format_host(request_lines[1])
    format_accept(request_lines)
  end

  def format_first_line(line)
    split_line = line.split(" ")
    @diagnostics["Verb"] = split_line[0]
    if split_line[1].include?("?")
      @diagnostics["Path"] = split_line[1].split("?")[0]
      @diagnostics["Parameter"] = split_line[1].split("?")[1].split("=")[0]
      @diagnostics["Value"] = split_line[1].split("?")[1].split("=")[1]
    else
      @diagnostics["Path"] = split_line[1]
    end  
    @diagnostics["Protocol"] = split_line[2]
  end

  def format_host(line)
    split_line = line.split(":")
    @diagnostics["Host"] = split_line[1].strip
    @diagnostics["Port"] = split_line[2]
    @diagnostics["Origin"] = split_line[1].strip
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
  
  def return_diagnostics
    @diagnostics
  end

  def get_post_paramater(request_lines)
    @diagnostics["Value"] = request_lines[5].split(" ")[1]
  end

  def post_parameter?
      diagnostics["Verb"] == "POST" && diagnostics["Path"] == "/game"
  end

end