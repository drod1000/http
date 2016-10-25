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

end